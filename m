Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76A5C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EAD20644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFcWA2fw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfHOP2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 11:28:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33117 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfHOP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:28:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so2599019wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7ySHx2gCdOcjIme2TB9gfS7z1s8Aq8Y5cCzx0Vx45zg=;
        b=nFcWA2fwfrW59buy2JNIcCI/eoxVG1XgciG7VLDMD0uY3EsxHmT9sceBoJ1LYNNBcy
         MOfRDhwMJlOsKfHlXui5iquI9x3/r5XUAoAG0D7/t4XmEI2UKU6CHtr1l6OuVzEoI5uP
         UQQ8g7L6TVPfC9u/ubnEjQxTqWyICOciuAmrc0bQYmwEPs3A7cBGOc4nXYUozibOo0cC
         rdXx9aeHFaOtlq6wbPuvHkDSIFV6EaWmjxUyUE0W0QtWkfFHQPsqSFfAc5fbzD5X1mw4
         vzl8B9arUiwphJaJMfAJZ6Og007HiiHK2nN86UTO8ObdkrwvAcGrNAsegt9qB9n/E4Lk
         H++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7ySHx2gCdOcjIme2TB9gfS7z1s8Aq8Y5cCzx0Vx45zg=;
        b=RI30/pgGtmZI6BmzJHB9/IxYIu+Jeegk9r76j/VQva6Gt+JCLG6eNPVgBhM58+w3B+
         SRhQp+GxCoEt2NHlwdPUjcpnsl3Ug8fvdnqdAz2NWSGEga5tjZ/evZABV7kb+49FE9Lk
         87/MVCosqWlO6BLPuO1D4iCrgJDesr8yiCKFL22h9aN5nEfWtH+XeQLDLQUn5z2Zbr/Z
         XT/ulNH2Dnf+nluNY8+pHV87qUPQTm7/TIu0L+u3a/hEuyQItHpGrIR4oloY17flWFtf
         9b8x8ZceECNVFtprRgftLhynEz7qsSxvlMiqesybn2/waYrBrYh6Hsxwi16AnDw1fSuY
         F16A==
X-Gm-Message-State: APjAAAWjAqMQHOBvuj8UUalVA33eLCq6rIlmw4V0S7x34ahvvDDpCCrJ
        FGfDl2NDzqn5nvDqTH5HE/XoGhtM3th1ZJzfiNeFBoQY
X-Google-Smtp-Source: APXvYqzz6gyHm3vlGI40gdc7o+65StfdjcAW+O4APBp6oMbqSt+4D9jEeAhIx4kDVgAKXYikjXd4w9FwweE+ISkml+E=
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr5926083wrw.323.1565882892937;
 Thu, 15 Aug 2019 08:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190815051117.24003-1-kai.heng.feng@canonical.com>
 <BN6PR12MB180950AE744B37AAFADC2FEAF7AC0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <8D8229FF-933A-43CF-AE05-52E969E3B942@canonical.com>
In-Reply-To: <8D8229FF-933A-43CF-AE05-52E969E3B942@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Aug 2019 11:28:01 -0400
Message-ID: <CADnq5_MqvH-jUdDUOeBM6zgwYKiv21Wuejw4sR5TwY7bJss_ow@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Apply flags after amdgpu_device_ip_init()
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "anthony.wong@canonical.com" <anthony.wong@canonical.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:59 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> at 21:33, Deucher, Alexander <Alexander.Deucher@amd.com> wrote:
>
> > Thanks for finding this!  I think the attached patch should fix the iss=
ue
> > and it's much less invasive.
>
> Yes it also fix the issue, please add by tested-by:
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>

Thanks!

> I took this more or less future proof approach because I think this won=
=E2=80=99t
> be the last chip that needs firmware information, which isn=E2=80=99t ava=
ilable in
> early init, to decides its flags.
>
> Yes it=E2=80=99s intrusive to carve out all flags from early init callbac=
ks, but I
> don=E2=80=99t think it=E2=80=99s that ugly.

Not a bad approach, but I'd prefer to keep the power and clock gating
flags in the asic specifc code rather than in the common code.

Alex
