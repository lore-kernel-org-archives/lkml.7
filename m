Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E58CC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AE921848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSLG+adw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfHVAcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:32:08 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36251 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfHVAcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:32:08 -0400
Received: by mail-oi1-f194.google.com with SMTP id n1so3064231oic.3;
        Wed, 21 Aug 2019 17:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jr3mK8aUE2yUguzDU1hrTgHgECJqRZ+ccr8xQeGygQM=;
        b=vSLG+adwaSfVgcMAEZcrsf8ADotC2eDvm9IixaNbc3y8E1Soo0/zNKa7/XQh4egVoU
         3umcoZ69sD+WnnCWsoLfSVRAIvhABXFOgwkqi54F53SO5GIeB4eQ9nKxke3o2kRCoeoT
         TjrzK3L0PRFWDlm0LmdXkr+vIa3DZPmKEvE7b6WB6YC8waoRxQ8zWklj2bXEpTX5UoxV
         EpHjdKV/AbPfy5iyyASFDh7iT2HrZ6FtHJ+poOAu54eWwHi90DPiNiYrQMT4zREb0NcI
         Pr/C8LGSzgOf+4VzIXJoxVjoHGJUZzOhT2DKRh9B/Z2D3klzTaijHFFzUnx+st00Sxw7
         cm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jr3mK8aUE2yUguzDU1hrTgHgECJqRZ+ccr8xQeGygQM=;
        b=Jzx3MNllOE7SF5pPl1SIzjrNxNNwz+VQ1JNDRfBAxafOhlbCJcclf03xLdbXBPZWGe
         hKxDlKxWH1GFhicydFv03XJHIZphYfHHJQUIMDTM22KKIQLSue6YQEhIWYt2O5VUlm79
         0m/yMeWewZNiT8qUOXth54OoHmYGR9eAk/yxi5jRUhIMyi9/S3ERkR+04g0hz0X5C8hN
         nz4DYWQTzy177bCsnP7yOcZuGX3HePkrUIDeLRCZWKzA1w1GkyxP57dxfsZGclRFSECu
         gQqMOBPkVke5Y8tNXOcMF/WMEnqTGlsmaYQENrrLDBY1wLVkDRjUzJyCwu3E2cBLa3NP
         D/gw==
X-Gm-Message-State: APjAAAVDtCdNR/zIdQI0IPjgk90jKT/AZbTh2w4uzvPIOnyj/nAIQI4u
        xG3FTktHL3puPygxoraXI6MKY8FnTZbLtm3XZBM=
X-Google-Smtp-Source: APXvYqwJQuZdio5EyiM8IZPTgVIwPe0iG0WfifeafN1AwzQwI63F8a7jvl82bApw7/J/MQsTmXxeuZi+s7h58iv9SqY=
X-Received: by 2002:a54:4814:: with SMTP id j20mr1939628oij.33.1566433927244;
 Wed, 21 Aug 2019 17:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <1563154124-18579-1-git-send-email-wanpengli@tencent.com>
 <ba3ae595-7f82-d17b-e8ed-6e86e9195ce5@redhat.com> <CANRm+Cx1bEOXBx50K9gv08UWEGadKOCtCbAwVo0CFC-g1gS+Xg@mail.gmail.com>
 <82a0eb75-5710-3b03-cf8e-a00b156ee275@redhat.com>
In-Reply-To: <82a0eb75-5710-3b03-cf8e-a00b156ee275@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 22 Aug 2019 08:31:33 +0800
Message-ID: <CANRm+Cw4V9AT1FOAOiQ5OSYHYcka_CxxKLewsPfZ9+ykTy354w@mail.gmail.com>
Subject: Re: [PATCH RESEND] i386/kvm: support guest access CORE cstate
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019 at 15:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/08/19 09:16, Wanpeng Li wrote:
> > Kindly reminder, :)
>
> It's already in my pull request from yesterday.

Do you mean this pull
https://www.mail-archive.com/qemu-devel@nongnu.org/msg638707.html ?
This patch is missing.

Regards,
Wanpeng Li
