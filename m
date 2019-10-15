Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CC5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E2920854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+tPP0GB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389293AbfJOTJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:09:43 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37074 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfJOTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:09:42 -0400
Received: by mail-oi1-f181.google.com with SMTP id i16so17838188oie.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Q5Zo1uyhPYG6G7rTKh8WceKdBKvJFHm7/Pwp+7AiANI=;
        b=I+tPP0GB9zILSUMWX/jeokY6vwDDPJ+6es6VMtDRhI5pphLjsrv3wAwLXlTiksjTgs
         HEMP6YSgWy4kuFlwWEleLbcOY8wk1xTMiOoRTiDLE7lOenpkccNJDfKEkluP+ExDLR8o
         O9vFybaV9QyDoezyy9enb+l+72HpEMJZ9QOp34lwbHfq+8m0vifE1Um9U6TrcdIkz4tb
         CLmw0W1S48OjRezqoiSbdid5zeJzOTk9ncc92Y6Hlx74NFm3j1A3FNmCabCm1PjGVxCr
         7h5DsK531Jy40yqyf6oMP0/5uq0ikn3yO+UbhOY5SHm7VMFkAf5/pmrugY46h+AsxxmM
         NcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=Q5Zo1uyhPYG6G7rTKh8WceKdBKvJFHm7/Pwp+7AiANI=;
        b=RlOhCQ3pDo97wIAiz4zjlQvl/ZQwpa8XN2PFBWl10QOS1sTjdBSM9cpVzoUBXOW7MR
         bDeKGV1RMnfmcCPc/AsjBWQQMqIYwSVbQAkkEad7RtQj3PW0DhorNkfk1wCLsyeznz3w
         dlVYTGIm2OV5L65k0i1GNWO28QvDZhWZVNtPWk/LAO4ZiuC5ynV8vL2vpk08kbc+hlc+
         EhuPnESBbFMY/JhLN01l77D7IMsxLM19Ua+ncB0HvQ0LHRsMl03xyNc1h0jfBYnrVdLy
         4qkR12BcA+9hvi3OSahjwYq929IY5wwrSYRiAPQKqJFM5qrteIq4gIvhFUcujZgY7nrN
         lD0w==
X-Gm-Message-State: APjAAAUmd3JroPdToSWznK2VOAGuiVrYYa6BGwkj1D2XMGCkh3Fi+Z6K
        DLFVI7BBT7nYODB6uOMU3XA0CbRa
X-Google-Smtp-Source: APXvYqxO9S3taEX88YfP36u6CEHGycPRZ/vEL74uqHiGivER7tejdwItjLofbToXAyrqHnlqLIuXYA==
X-Received: by 2002:aca:620a:: with SMTP id w10mr121743oib.0.1571166581359;
        Tue, 15 Oct 2019 12:09:41 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s66sm6937597otb.65.2019.10.15.12.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 12:09:40 -0700 (PDT)
To:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Build failures since 5.4-rc3
Message-ID: <2da85bba-ab2a-b993-be1a-c98222819b37@lwfinger.net>
Date:   Tue, 15 Oct 2019 14:09:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe,

Since commit 294f69e662d1("compiler_attributes.h: Add 'fallthrough' pseudo 
keyword for switch/case use"), builds of VirtualBox are failing with the 
following errors:

  1954s] In file included from 
/usr/src/linux-5.4.0-rc3-1.g2309d7d/include/linux/compiler_types.h:59,
[ 1954s]                  from <command-line>:
[ 1954s] 
/home/abuild/rpmbuild/BUILD/VirtualBox-6.0.12/modules_build_dir/default/vboxdrv/SUPDrvGip.c: 
In function 'supdrvTscDeltaThread':
[ 1954s] 
/usr/src/linux-5.4.0-rc3-1.g2309d7d/include/linux/compiler_attributes.h:200:41: 
error: expected ')' before '__attribute__'
[ 1954s]   200 | # define fallthrough 
__attribute__((__fallthrough__))
[ 1954s]       |                                         ^~~~~~~~~~~~~
[ 1954s] 
/home/abuild/rpmbuild/BUILD/VirtualBox-6.0.12/modules_build_dir/default/vboxdrv/include/iprt/cdefs.h:1169:44: 
note: in expansion of macro 'fallthrough'
[ 1954s]  1169 | # define FALL_THROUGH      __attribute__ ((fallthrough))
[ 1954s]       |                                            ^~~~~~~~~~~
[ 1954s] 
/home/abuild/rpmbuild/BUILD/VirtualBox-6.0.12/modules_build_dir/default/vboxdrv/include/iprt/cdefs.h:1176:33: 
note: in expansion of macro 'FALL_THROUGH'
[ 1954s]  1176 | #define RT_FALL_THRU()          FALL_THROUGH
[ 1954s]       |                                 ^~~~~~~~~~~~
[ 1954s] 
/home/abuild/rpmbuild/BUILD/VirtualBox-6.0.12/modules_build_dir/default/vboxdrv/SUPDrvGip.c:4192:17: 
note: in expansion of macro 'RT_FALL_THRU'
[ 1954s]  4192 |                 RT_FALL_THRU();
[ 1954s]       |                 ^~~~~~~~~~~~
[ 1954s] In file included from 
/home/abuild/rpmbuild/BUILD/VirtualBox-6.0.12/modules_build_dir/default/vboxdrv/include/VBox/cdefs.h:32,
[ 1954s]                  from 
/home/abuild/rpmbuild/BUILD/VirtualBox-6.0.12/modules_build_dir/default/vboxdrv/SUPDrvInternal.h:37,
[ 1954s]                  from 
/home/abuild/rpmbuild/BUILD/VirtualBox-6.0.12/modules_build_dir/default/vboxdrv/SUPDrvGip.c:33:
[ 1954s] 
/home/abuild/rpmbuild/BUILD/VirtualBox-6.0.12/modules_build_dir/default/vboxdrv/include/iprt/cdefs.h:1169:56: 
error: expected identifier or '(' before ')' token
[ 1954s]  1169 | # define FALL_THROUGH      __attribute__ ((fallthrough))
[ 1954s]       |                                                        ^
[ 1954s] 
/home/abuild/rpmbuild/BUILD/VirtualBox-6.0.12/modules_build_dir/default/vboxdrv/include/iprt/cdefs.h:1176:33: 
note: in expansion of macro 'FALL_THROUGH'
[ 1954s]  1176 | #define RT_FALL_THRU()          FALL_THROUGH
[ 1954s]       |                                 ^~~~~~~~~~~~

I think the internal macros in the Oracle code are correct - at least they 
worked before the patch in question was applied.

I would appreciate any suggestions.

Thanks,

Larry
