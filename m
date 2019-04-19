Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D75C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7AE2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4nFyc8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfDSTko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:40:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37367 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfDSTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:40:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so3009577ply.4;
        Fri, 19 Apr 2019 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g40v1EbfT9OHGkM4AcYQV2Z11wIyYAkYz8Yz3g/jliI=;
        b=A4nFyc8ce0tef/USjR+ECBoLVZDWjjOmjgHeiOiGQlkdFVqRG1XtE19i/EDgsj9MDN
         3PEmzObomswX1vIq9gT2dSuBAOYqjdfDOkiHQSap4k5PYnMuWUQh77YGws39xen2ZjRf
         K0AYAx3xy+zkp2NfJMxku/aInEd31wO9ltca6mqG9VMs+LnHE+FmxBruKuyZSbv1vpdK
         d8dlPq2Ck+VjWOIM5EKO/yDNGkG09XwUb/4JSUjp5TyHxkbWwagO+9y9IvL9xaDxFa2V
         nbaj74kQoNudX8mgl37wQQIP4AXHIGAwpe19AAPxXTeSuoL9SMtcrLMnsPbXR1w29mkX
         jwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=g40v1EbfT9OHGkM4AcYQV2Z11wIyYAkYz8Yz3g/jliI=;
        b=DkSUeRKXFlW4m/uauW7HQsw4PG9oBPaky0pvJWidYBXTKBLQl8sCAShb0MQzR5GCnS
         0G2MFeINe+ZR/KmfP6AyuELW8MreQyPvMPmS/ebRNFzzwm5NHBjA6/zQl6sNsr7vwOq4
         82JLtgeRlR7BdM3zNBdrwOpXXYXHcEFK/2x4x5fa5APbHf89OWrfHJTAMrn/IRCOztbK
         pjtp//gF4gV01FwZy/GJNecJ66QpNxtcjBy9fyoQv+gh43DRTHFfoulfa0t6CbEkPA06
         61LWOdBXa+e80EZ97e9QRsl7bCeNu70LKFp4gnxxJGQE5FsZbaSB2Bwgv7PvOHsRRuxf
         EYuA==
X-Gm-Message-State: APjAAAWEz8wigJglRePBHIPvyXiq0YG5kQSyxK0gKdLJ735SIeqILAgl
        Y65OyVjJiDA+1Uw2JPMULxhp6Rsj
X-Google-Smtp-Source: APXvYqwHABOxOJ5/tJBiGr0p7BCE+Su3HwmSefXHuG4XWLqWzjf+5xhOudlZPVG49bb7/80tPEmkDw==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr5611486plv.90.1555702843134;
        Fri, 19 Apr 2019 12:40:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q128sm7981630pga.60.2019.04.19.12.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:40:42 -0700 (PDT)
Date:   Fri, 19 Apr 2019 12:40:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/110] 4.19.36-stable review
Message-ID: <20190419194041.GC10320@roeck-us.net>
References: <20190418160437.484158340@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 07:55:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.36 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr 20 16:03:29 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 156 pass: 154 fail: 2
Failed builds: 
	i386:tools/perf 
	x86_64:tools/perf 
Qemu test results:
	total: 349 pass: 349 fail: 0

Guenter

