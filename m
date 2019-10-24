Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57EFCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B79721D82
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHeBh7de"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410179AbfJXRFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:05:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39115 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2410164AbfJXRFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571936722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03+5VBqCPd68lTAQRb1/kJfIJ/zUP3/Day5xyJuYTDk=;
        b=iHeBh7deK3GUuk+MT5EmdtQT+VJqfR8JxS+SlMf2gE23/BI84cqdwl/tsPscol6y8bj/5D
        llz8i85IW3NpG8OFRbpE7uc/K/+Wg8trPWVTqQdrGCX9pVV2cIHo/CcfmpfFqitCByWsZN
        Ubbvi0xrSCSlOc9v6hO8LuAv7MNBR4o=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-2XGw77MHNBi44lXx18IItw-1; Thu, 24 Oct 2019 13:05:18 -0400
Received: by mail-lj1-f199.google.com with SMTP id m7so353982lje.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 10:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/o8TfhScpVV/SFKEy17AB1Zf2axWbjJiCRdK+oaodM=;
        b=VMkrt3HbWdkDCRgmDg5dqVeKt5QGoeJo6phR/vTfbpOGBTznhjOebSHdDFRFNVexrK
         daDEeeCCIwm8d5jL2XbQMpveZBcmhccqlMrGqIqQCZB8sjijY/0XPHF12iPUBVx644j+
         WwihCzmpBqngrQZzp4oGxlU+6Jy7PuBB/Dr+Iu1bIZBK+3KXSgh7h9cq/3tNIfP8Vj8t
         qQtXbEU+Po9sRzeLqQ4xVeyQotol5G/EPDyT7gNW5GSf28SlhEt1G/XqPIadUW5O/LJO
         +3n9PQXagRAp1LTW3Jb5taVkWhWa0LG3EHKb951QlSOEHLFW/rAso6y8LAyPTOZXTVKB
         rkYw==
X-Gm-Message-State: APjAAAVNdS/XEDBEaApmbwP4Uvszl1bs4kuQwRRrbRUGs+eSdXRIdZ3s
        T0YsoJ4t6CsRYyyW57EPI+bOP/B0c7KRMUS3j3wpQ3rZrM4iPcyVzgEMfKehWsC8Nd0wEVO3Rhp
        qPQFT3JEyQ4knbS3e6H4Pwd+eDKUfGT+IMr+v9aHf
X-Received: by 2002:a05:6512:51a:: with SMTP id o26mr3538272lfb.132.1571936717132;
        Thu, 24 Oct 2019 10:05:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzIPhBNg98lecbpGanzXdv/jvDEOMcLhjDgpSTFOb/kzuzr1Y8DKoHvodVSYY7pWM8MkSV9AFU5hw5SZdcroyw=
X-Received: by 2002:a05:6512:51a:: with SMTP id o26mr3538262lfb.132.1571936716917;
 Thu, 24 Oct 2019 10:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191022141438.22002-1-mcroce@redhat.com> <20191023.202813.607713311547571229.davem@davemloft.net>
In-Reply-To: <20191023.202813.607713311547571229.davem@davemloft.net>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 24 Oct 2019 19:04:40 +0200
Message-ID: <CAGnkfhwbuXS7hYWuBqERi-FA1ZbjFqWN81aOP_MpcqsmPkkLVQ@mail.gmail.com>
Subject: Re: [PATCH net-next] mvpp2: prefetch frame header
To:     David Miller <davem@davemloft.net>
Cc:     netdev <netdev@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        LKML <linux-kernel@vger.kernel.org>
X-MC-Unique: 2XGw77MHNBi44lXx18IItw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 5:28 AM David Miller <davem@davemloft.net> wrote:
> You cannot unmap it this early, because of all of the err_drop_frame
> code paths that might be taken next.  The DMA mapping must stay in place
> in those cases.

Thanks for noting this.
I'm sending a series with this and other small fixes.

Regards,
--=20
Matteo Croce
per aspera ad upstream

