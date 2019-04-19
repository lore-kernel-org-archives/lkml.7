Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B01C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76478208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="jIsE2N2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfDSUjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:39:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41665 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfDSUjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:39:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id x10so6007381qto.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=seRQcUwfPOFMjx1V/IOvlvE0dVnQSN41qHuqF14IK7A=;
        b=jIsE2N2JCoNY9lrzpJMYrAV9cRAfC4XMj/kCX1givnh9sO0di2QaAlqmUlFEZ31C7x
         Le1DTPzcg02ws0BmHePfK7YLYgyiEpjAv4+m9z1ntmKKBRSkHNSizMTVE2uPohC0X55Q
         Y8jSWRGTIQOpwpbjIPzhvz0BCWtd3C606NcpdKEgCPk6yxkivNzNFpc2TuiolMrpMBsp
         o7hk95v3F9S5BPiuce92KK5RoeBpMGdsbPRWxXgcmAX9rFDvOtc6MZ8CNHYaMsiqpkvW
         FGh8fdQYJAYAXeAO+gfsyXvfw7F4yNFoV+S0gkbxkbl3ZzjXPCYIx9JeALgHBt6ZFqE2
         MLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=seRQcUwfPOFMjx1V/IOvlvE0dVnQSN41qHuqF14IK7A=;
        b=RsoY5w5ufTlp8U04bjblV2mJ7DKh3V95qV+d4jJOFQc9gsIqdmRKkkHXv6jF/Qh3OL
         PyIXVivdzXW8/CrISu8sBuFkijOzpcIzl9IqKmaiIXfImHDZXEuvUZJ7L0Ct0+p1G1C+
         zaY3fZnpOL5tdVBlh8KrdoPoKgFIO7vPCcduhxghLUix27kxuwLNyXXnJezvXAhp6p7j
         5Um0MKQTyiKgYJAaWzP6c/WvhJ1BPQtdMDPCso7pgIJlWawV7RJDzONM+CcBaDIrIKBP
         sOlWWXkTRqpRPDiJHTaScZZlE+WL3u14dbdmi6YQNiumpsYWNGbJSYTof7cwpMn5eu5q
         Q+lw==
X-Gm-Message-State: APjAAAW7UuHC6EctRgtCL28iDMxd+kBLLwQxsEQr9acSG+qJF8qEtapo
        ZSMx+IASg8WgQQjV2R5LBugSBAFZcsfddiIJ0AuS3JBC
X-Google-Smtp-Source: APXvYqyyROQBkaMROlywCc2I6dRFmvNECJJaQLPJjGkMDbWSqnFPeCPEEw/nSC45eW1Z26ghDLaMeS0kSFyuDVVFBcY=
X-Received: by 2002:a0c:9945:: with SMTP id i5mr2393095qvd.159.1555663957110;
 Fri, 19 Apr 2019 01:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190418064648.25706-1-chiu@endlessm.com>
In-Reply-To: <20190418064648.25706-1-chiu@endlessm.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 19 Apr 2019 16:52:25 +0800
Message-ID: <CAD8Lp45JbfQ2LVMT0LNV7j+D2GpCzWU36KHqaCvh9kKQOAXkNQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Add fn-lock mode switch support
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 2:47 PM Chris Chiu <chiu@endlessm.com> wrote:
>
> Some of latest ASUS laptops support new fn-lock mode switching.
> This commit detect whether if the fn-lock option is enabled in
> BIOS setting, and toggle the fn-lock mode via a new WMI DEVID
> 0x00100023 when the corresponding notify code captured.
>
> The ASUS fn-lock mode switch is activated by pressing Fn+Esc.
> When on, keys F1 to F12 behave as applicable, with meanings
> defined by the application being used at the time. When off,
> F1 to F12 directly triggers hardware features, well known audio
> volume up/down, brightness up/down...etc, which were triggered
> by holding down Fn key and F-keys.
>
> Because there's no way to retrieve the fn-lock mode via existing
> WMI methods per ASUS spec, driver need to initialize and keep the
> fn-lock mode by itself.
>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>

Reviewed-by: Daniel Drake <drake@endlessm.com>
