Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D726C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BAD2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Gd3Zdt2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfC0J5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:57:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44943 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfC0J5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:57:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so13616729wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 02:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tndweEsnu1SYspGnxv0FoaY2zcER18S8te5CmcHWPj0=;
        b=Gd3Zdt2bhJPrSU57c9w0JTUjRSO7CzRc/4vTjcuNcA9xI/XyPMz1V8afK8QRnJvb0F
         IFSbD3Ie3et8BPXCSnylKD7e0pVdv8zaG59zu/oqecpdo5TSiYF0gro9aHRSrfkFEgeo
         TElUFN0jhJSyFNO9dpz3fiHMRa85XpqBAtYc6USRwuSXVHUcmyUdNvvfflNXnCiVMwcP
         Pfi9sGMUpsOIc5GObdATq1tZcWaD1P6fqJsKVLaGNZ90IYAsOiWEU+zXAwiwT78RiHhn
         R6Vep21DJ35E0UYUxedpoh9XWzk1Rzv2NdCLB4YrbDQUxxoKl4Ebwzpw9TPoqOG2h82G
         octA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tndweEsnu1SYspGnxv0FoaY2zcER18S8te5CmcHWPj0=;
        b=hrGk5HK2mdEwjKvqHWiR8yaR8OqyQ2kBZ6D1xHtS3eTguEyHEYc4Ep2nrCTI5GAaV0
         uRKlB1D62yy43cYkKjHb11ghPGQ9HA8z+J/sAqbg+CrnOXnPRP9q6A7pjZEerA+7KXj/
         ld6+0do7SVNGHjYZ1Z9c8TD8P8VZyCp5VLZeyF33imCQIgsiYycmQoB6fXN71QGI8BnS
         nC8HjLXuJR6CumUv9BHRh5uo5v0/RKXIF1sInK7S9gW/gNqZ5Gp2Uxt5jW6AS3HBfruo
         pmhhOYu/qhf0n7ocJ37c3YW8MWfciYAJCTOI2PjAlcMmJdst2D0e5JPbPvwuRe8bpsnd
         cBxA==
X-Gm-Message-State: APjAAAU33wMYbD7aPa9KrpWqEys8fSPKda83COPn/aHkZCZHpGNLDtKf
        IeIDXlwEpxNrfxCjXN10EMSnZ52untc=
X-Google-Smtp-Source: APXvYqx9zp4ZbpHtzSM7QSrf5Eghid4tDQYkuhVk0PE4C3eKyaCGI5lnF1Jl6enIRkPQmSriUO0MRA==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr17575970wrm.14.1553680670940;
        Wed, 27 Mar 2019 02:57:50 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id v184sm20963871wma.6.2019.03.27.02.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 02:57:50 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:57:49 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 07/22] ethtool: netlink bitset handling
Message-ID: <20190327095749.GD6979@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <9123f942b484ef4bbb684bb1f4aa2b70d673a259.1553532199.git.mkubecek@suse.cz>
 <20190326155911.GA4958@nanopsycho.orion>
 <20190326175932.GN26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326175932.GN26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Mar 26, 2019 at 06:59:32PM CET, mkubecek@suse.cz wrote:
>On Tue, Mar 26, 2019 at 04:59:11PM +0100, Jiri Pirko wrote:
>> Mon, Mar 25, 2019 at 06:08:15PM CET, mkubecek@suse.cz wrote:
>> >Declare attribute type constants and add helper functions to generate and
>> >parse arbitrary length bit sets.
>> 
>> Hmm, this looks like a lot of work. Two things:
>> 1) This is generic. Not really related to ethtool in any way. Could this
>>    be done in netlink common code?
>
>I suppose it could if other netlink based APIs would be interested in
>using it. The only ethtool specific part is the support for "legacy
>style names" (fixed size strings) but that is something I'm not really
>happy about.  Perhaps it's time to return to the original idea of
>supporting only arrays of (char *) and creating them around existing
>fixed size ones.

Wait, could you please describe this more?


>
>> 2) Did you think about leveraging NLA_BITFIELD32? What I mean is this:
>> NEST_START
>>    NLA_BITFIELD32 index 0 (bit 0-31)
>>    NLA_BITFIELD32 index 1 (bit 32-63)
>>    NLA_BITFIELD32 index 2 (bit 64-95)
>>    NLA_BITFIELD32 index 3 (bit 96-127)
>>    ....
>> NEST_END
>> It is basically an array of NLA_BITFIELD32.
>
>That would be similar to compact form but it would introduce the
>interleaving and extra struct nlattr header for each block. I don't
>think it would make things easier.

I'm just trying to figure out if it would be possible to use existing
building block instead of introducing new ones....


>
>The verbose form is meant to allow requests like
>
>  ethtool -K eth0 tx-vlan-stag-hw-insert on
>  ethtool -s eth0 advertise 1000baseT/Full off
>
>without either keeping the table of available flags in sync between
>kernel and userspace (all userspace users of the API) or having to ask
>for the list first (in case of one shot requests as above; long running
>tools like "ethtool --monitor" or config management daemons would keep
>the tables and use compact form).

Okay, I have to go over those patches but this smells.


>
>Michal
