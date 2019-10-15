Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59ACECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B348620663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfwjUb2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbfJOU11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:27:27 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36053 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387773AbfJOU10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:27:26 -0400
Received: by mail-oi1-f179.google.com with SMTP id k20so18022029oih.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3gs7JtL/w3i6/+vkCf5VuZ5WSCpvMGTgZQy5oiexumQ=;
        b=EfwjUb2QBc+8WAOHALTflt5AdbmetoVvNXUPGtdO2MVBAWFO1Dp51cZPMTzX13Gnh2
         uSXEbX4Gt3G14at0fp95gzr3UCNq83TfUCRpcL4rf+/ya8xmV8N6ioHenhAs/UJinUCa
         4ihMWKy+jNgwi6DDW+33jngGdhGvSsMtwc/mgTnQUE+dDOKSHmEumkslzf3/qJFiB+l6
         CJRrykKFYp349d5t3Lyg6nDSTe13kNaBk4RxuaRC1zS6lnIRoI02Vv7MeQAAPKyHCPjj
         LnxhtsBEVeL/0pEuIMv4FdnOMbMWW4iXIxG66Dpil+Si4gPJ5a1Y8V0/x22txxZBuAt4
         xX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3gs7JtL/w3i6/+vkCf5VuZ5WSCpvMGTgZQy5oiexumQ=;
        b=bGn6RoYsXM9trngOOwet9LjCamASItXgXh+qIFU9LcZuloxMJbhpJDpa96gC/72aZ0
         oBx0MBjN26mbAgGr+2Isy4VzxyliEEeRcMcL/6Bi1lYs6MMsw87WwNWUpteb5iTGbAL0
         QLkAmv8DtimS4qW8/Ly23iAnOsNTpAY77KAstF1I6OS26Z911ccen1ADgTQCEggTgOBG
         OlwDCIZKVmQJTpjpTfM51bdHkfbelvANLTs7tvM0f5TrFLczFjNCiT+u4GvDX+Mqz4GU
         AzsW83LJGUJNY+rhEQhTiPam0+HcrcQe3/5keVstaUBHpvvu/w8LJ5hdTUypDNJ9jLxk
         nOaw==
X-Gm-Message-State: APjAAAVhDbL0AzPfDCKanhnXNPt9+O9Htz89RF/FLN2ajGhhuISjRfaP
        yB5wW5/AZVLONzcspQus10qHx5vF
X-Google-Smtp-Source: APXvYqzrO7X+eLgL9lPADvCwj3hSEGT6lF0nxiUVkzh6UXoDBCSg1naOCCMsw9JCFAfY74gjbP3/4Q==
X-Received: by 2002:aca:e109:: with SMTP id y9mr74986oig.27.1571171245657;
        Tue, 15 Oct 2019 13:27:25 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 101sm7188094otd.18.2019.10.15.13.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 13:27:24 -0700 (PDT)
Subject: Re: Build failures since 5.4-rc3
To:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>
References: <2da85bba-ab2a-b993-be1a-c98222819b37@lwfinger.net>
 <44f9a9bde7cf7885a8e55a52260b59240cb9a157.camel@perches.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <bf0fbe49-65ec-e110-e937-b3b18df126c0@lwfinger.net>
Date:   Tue, 15 Oct 2019 15:27:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <44f9a9bde7cf7885a8e55a52260b59240cb9a157.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/19 2:32 PM, Joe Perches wrote:
> 
> Hey Larry.
> 
> 
> Looks like this should be:
> 
> #define FALL_THROUGH __attribute__((__fallthrough__))
> 
> and there appear to be many of these #defines that
> use __attribute__((foo)) where foo does not use the
> double underscored prefix and suffix form
> 
> I also downloaded and trivially attempted to build vbox
> without success, but I don't find this #define anywhere
> in the sources.  Clues?
> 
> $ git clone git://github.com/mirror/vbox.git
> $ cd vbox
> 
> $ git grep FALL_THROUGH
> $
> 
> $ ./configure
> Checking for environment: Determined build machine: linux.amd64, target machine: linux.amd64, OK.
> Checking for kBuild:
>    ** kmk (variable KBUILDDIR) not found!
> Check /home/joe/vbox/configure.log for details
> 
> 
> $ cat configure.log
> # Log file generated by
> #
> #   './configure '
> #
> 
> ***** Checking environment *****
> Determined build machine: linux.amd64, target machine: linux.amd64
> 
> 
> ***** Checking kBuild *****
> ** kmk (variable KBUILDDIR) not found!
> 
> $

I am the maintainer of VirtualBox for openSUSE, and it is their version that has 
the problem.

The original code had the following macro definitions:

# define RT_FALL_THROUGH()      __attribute__((fallthrough))
#define RT_FALL_THRU()          RT_FALL_THROUGH()

The code uses both forms interchangeably. That failed - I think the () fooled 
the compiler.

I replaced those with

#define FALL_THROUGH          __attribute__((__fallthrough__))
#define RT_FALL_THRU()          FALL_THROUGH
#define RT_FALL_THROUGH()       FALL_THROUGH

My initial try was without the underscores around fallthrough, which caused a 
conflict with the one in your changes. Putting them back resulted in code that 
builds fine. Thanks for the help.

Larry

