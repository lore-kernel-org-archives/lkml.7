Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0218C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C311920663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+SPwpl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfDPUbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:31:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41622 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPUbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:31:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id d1so10885559plj.8;
        Tue, 16 Apr 2019 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kCyaUCGVc/V6ZyQOKtuzykzGifqfq9ikv6LcWKWTfVU=;
        b=J+SPwpl35yPvHJvJZ07r8o1l2k8iBLdOLSUgh3hA52oOCQvnOmI/UtNV7IcX+wYfkE
         ENWd7wa2xE9c9wXvpgX+FqcJYCa5LtEB+0ZGfd/lBqbPLZhPUnItDgM42vg/wwFzFI/3
         0KGQQHYgl/IJutFNMyNnnitvjHPrnXrkMfK256Bwj25KM8TpjQCDleaNq1aTiW921Ts+
         FF3phjjQQ0b29KLaMt5BORp7Fgrym9NeT6rlbak8owR83BkYtHJiq6muO9Pg9p5aG4PD
         KreMwl56PPQm0avEhhwEWmr2+mrYBxuFT3vi6sS5o3Nmp/l2gMIeH6gVxOA6F2oEbVC+
         NidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kCyaUCGVc/V6ZyQOKtuzykzGifqfq9ikv6LcWKWTfVU=;
        b=dT3X9c78jW9qLEyTirluXCvDlIn5S9daenfTUuwOVxogPag6Hek/NUvN6iAhtI4iL7
         4/rDJfFaOr7U9wOdlEwiRoaMPPEDsD1VUW1NBVevdIXgCJ24JOhuPhRj7GqqPVrRX+qO
         4Myx8PRU1AWGWd5vwR1eomP2NWdU+84km8TBc5/INc5GceXZgK+kyfOr/P0BmWxShgaS
         04pSWMRD4afJXVTC5S2A7cKh9U61EBzf+iTv2gaRmKqM8mApaHqhyt2kvBFkpDnO+dIw
         kvGjyP4Hn66ye2p15B7ag56xlTxNR/k/jzYQvxTt9hrvtj/+BGiwTqu8bkQb3w+4BbIM
         /Qiw==
X-Gm-Message-State: APjAAAV/xnrsPxdOlvGzM2jUwipqS5qLdjV+pOdj6XLd1tUfixAMImfT
        NdLJ9TwOCLSftNCdiVZaWoo=
X-Google-Smtp-Source: APXvYqzUOhZnFUrYJ3CgrX3jDbq+IXxjHEH7hysLbncDjc6qCSVo+371FJ8CPB/OYsHBPFtMOU/9pA==
X-Received: by 2002:a17:902:2b88:: with SMTP id l8mr80447832plb.262.1555446675674;
        Tue, 16 Apr 2019 13:31:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j12sm65163698pgg.79.2019.04.16.13.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 13:31:14 -0700 (PDT)
Date:   Tue, 16 Apr 2019 13:31:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jean Delvare <jdelvare@suse.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
Message-ID: <20190416203114.GB25517@roeck-us.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net>
 <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net>
 <20190412100451.6fe49de7@lwn.net>
 <f900adea-d231-c00d-847c-33e66e79ea30@roeck-us.net>
 <20190416141949.09b48789@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416141949.09b48789@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:19:49PM -0600, Jonathan Corbet wrote:
> On Fri, 12 Apr 2019 20:09:16 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > The big real-world question is: Is the series good enough for you to accept,
> > or do you expect some level of user/kernel separation ?
> 
> I guess it can go in; it's forward progress, even if it doesn't make the
> improvements I would like to see.
> 
> The real question, I guess, is who should take it.  I've been seeing a
> fair amount of activity on hwmon, so I suspect that the potential for
> conflicts is real.  Perhaps things would go smoother if it went through
> your tree?
> 
We'll see a number of conflicts, yes. In terms of timing, this is probably
the worst release in the last few years to make such a change. I currently
have 9 patches queued in hwmon-next which touch Documentation/hwmon.
Of course the changes made in those are all not ReST compatible, and I have
no idea what to look out for to make it compatible. So this is going to be
fun (in a negative sense) either way.

I don't really have a recommendation at this point; I think the best I could
do to take the patches which don't generate conflicts and leave the rest
alone. But that would also be bad, since the new index file would not match
reality. No idea, really, what the best or even a useful approach would be.

Maybe automated changes like this (assuming they are indeed automated)
can be generated and pushed right after a commit window closes. Would
that by any chance be possible ?

Guenter
