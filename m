Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1F5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4608A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="zBR+Qy2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfC0J0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:26:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38651 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfC0J0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:26:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so10223295wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8LLwSdyPWGqlp4Bzp0+4r35rrwN84Sc823Flf31HzUU=;
        b=zBR+Qy2ngxhlmx0bhOflb4EWbBzIQufoYWEwQINj49YmvS3Bbprw9iODeMCa0l3Fe4
         DdNbtQqBFMI/+8/XrdXwZiay/wy78XrjX00M6rl1aPJMjFJFU5uUdjd6i7q/hha2Ujpb
         ubXYr4sMIZ9K0qI1H5C7M7hAEw46TFL1jPz7US5iQpft3UbE26M+JaAcuRhDLvNt0Ipg
         N6/7UYgt4hLglA6+0DulTF0zcKIT5PrTYIMNkodN5O6uBCBZox4RFXgD3BdOjIEoEN5k
         dPdeIzruXQrwnd2Ao8weoqcRXmI36LdCqFgqoLX9IZdt7B+kpuc+isZPl12B7Zbn3hiv
         pRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8LLwSdyPWGqlp4Bzp0+4r35rrwN84Sc823Flf31HzUU=;
        b=GeqqsaivAfTBkNiCrfJtXsSuxQ8SVjW5N3TQ0ZpLe74qe5ubkREqg0cVWiviNM3e1h
         8TU8KZpbWmgrpg0Y29MECiX2K0KLfHL1MIaRzJOL2vsEGF4aCVdXKikldWTJc27Xnk4y
         oE6yjDerKdhYNa6ZBM4PTOqnQLCF0p30TbcycJ7QqfVY0N4za1uNrGcfz1PdyDPIU9fv
         H8ICr69Zk5zr9mV5kS371vf6hmhjnk3jgafrTUmThO/H0vSn04XpZL6Lj8ndebUotpKY
         UU4wS4nCPWA0JQ4eTjMFLtR2/3UER8qv4mEgJVluHmqf+ZzyFOnHY5GjXOYFXuvWUVzs
         Rpew==
X-Gm-Message-State: APjAAAVfxDk8CO0+fYZ2W5ZEAzRnn78TutWmvn837bAkZwj88rXd+ap4
        IiDzAxElLO0/OkDtahM/rIEmpQ==
X-Google-Smtp-Source: APXvYqx5+UgOTEkgqNoPRdEA6PfMKLBY51gkuoT74RPOQF4oXbubFck41RwE4OPOvsryrr1zHW3ucg==
X-Received: by 2002:a05:6000:5:: with SMTP id h5mr21844046wrx.271.1553678763176;
        Wed, 27 Mar 2019 02:26:03 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id z7sm2500551wrt.10.2019.03.27.02.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 02:26:02 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:26:02 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/22] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190327092602.GA6979@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
 <20190326163640.GD4958@nanopsycho.orion>
 <20190326173215.GM26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326173215.GM26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Mar 26, 2019 at 06:32:15PM CET, mkubecek@suse.cz wrote:
>On Tue, Mar 26, 2019 at 05:36:40PM +0100, Jiri Pirko wrote:
>> Mon, Mar 25, 2019 at 06:08:09PM CET, mkubecek@suse.cz wrote:
>> >+/* genetlink setup */
>> >+
>> >+static const struct genl_ops ethtool_genl_ops[] = {
>> 
>> Please be consistent with prefixes. Either use "ethtool_" or "ethnl_"
>> for all functions and variables in this code.
>
>OK
>
>> >+/* module setup */
>> >+
>> >+static int __init ethnl_init(void)
>> >+{
>> >+	int ret;
>> >+
>> >+	ret = genl_register_family(&ethtool_genl_family);
>> >+	if (WARN(ret < 0, "ethtool: genetlink family registration failed"))
>> 
>> Why do you need this warning? Please avoid it.
>
>I'm confused now... few days ago you replied "+1" to the idea:
>
>  http://lkml.kernel.org/r/20190321162105.GU2087@nanopsycho
>
>I agreed that panic() (which is what e.g. rtnetlink does) would be an
>overkill but I would be definitely opposed to not having anything in the
>log at all and just silently going on without the interface (which may
>result in misconfigured network). I believe that if this fails, it is
>a sign of something going very wrong inside the kernel so that the "W"
>taint flag would be appropriate.

Okay. Fair. It's just that I looked over the code and did not find any
other genl_register_family() call with WARN.


>
>Michal
