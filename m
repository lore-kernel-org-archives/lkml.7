Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768F0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4328321874
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="De18o8v7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfCWCSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:18:23 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:44986 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfCWCSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 22:18:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id D6838E28
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 02:18:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oIrs0Ko5qHp0 for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 21:18:21 -0500 (CDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 9D11FE23
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 21:18:21 -0500 (CDT)
Received: by mail-pg1-f197.google.com with SMTP id z14so3804506pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 19:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=49BDh8uAQs0FlurZKtSoOCBnD+/2CKeGTvSVyoflBU8=;
        b=De18o8v7SC2K13tpazPaJ2Ovb2qfxhLcLudMZ8E7AFTD6MtnHuIXcrIBTOca4S6DAq
         XenLfQVWbuIbdiIzaNktPL7ieeCG2kT6KDxccU31apBFxgzukQpYTK/aBTl5iAtDwVa4
         B6EV6qt/6MsBlTsi1LXNXCoSH6pgAGQ/7BLAk6e4MeZvtH/ld1wqEBp0VvnlNXjPc2NO
         K736+6R7i4K+96PuBNVnJbi5dIxA7ZtAWeBu2JuphSn1IqkCDab37v2gHiQS4R8vVfVb
         UqXDYfq6F1UMsLk17kJ452TY5nysZRv86x16qV0nafwSq9QONKlwzPE+rRbufyWIy0Nt
         tGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=49BDh8uAQs0FlurZKtSoOCBnD+/2CKeGTvSVyoflBU8=;
        b=NqfpphgmR2cQr/7JdwpblNnteH5QfZW32VRIwKWVxmYeXQQTmP3CGvW0hbODso77tI
         O7/SliwTyoUWInKyUxWGO/E4siI0IGkjEdQ7bJVP5J2tJub2NicKdsJ5T5hR2BwK/KSB
         IheWDD64wGR1blOMgVZGAZSIssm01+jfdsSrZ/vKGDNmzHClUoVVuUn/2Dqp57A51EqN
         FsyXUa3XVfUnXmiHmqLy7bxItUKtZYVXGMP2lZXzhl+IFPu5iZxowjyC0JH+2neOz4Vt
         FzIdySdhnoRbCp/YwA3+WQB06fpKLlQfESDtvREAp/n/w9RcYQI4VOfaIUJJCwVYsCEa
         cgRw==
X-Gm-Message-State: APjAAAWhMeEyhrZIGudzR0YU5YtHLr3p3mTs5fLlGkW3PlitvPB9K59G
        G/pBT0KOJl1juM/Kf/rKfInDRxaX5AJIzULmFh4JwH/1t/IvHeEQRtcvZo8dHE/GrAJyiAPSO4+
        7J4ga5+TFES7ovteEqM3nKJGQ5eY6
X-Received: by 2002:a17:902:45a5:: with SMTP id n34mr13121803pld.127.1553307501056;
        Fri, 22 Mar 2019 19:18:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4R8NZs0UpRwEQ3M+DOha4DHOc6rbnGhKSo45eSLdEOMhK1L6iBANtzc8mjB8nfX6sKublNA==
X-Received: by 2002:a17:902:45a5:: with SMTP id n34mr13121787pld.127.1553307500763;
        Fri, 22 Mar 2019 19:18:20 -0700 (PDT)
Received: from [10.184.4.71] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id g143sm4987263pfb.157.2019.03.22.19.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 19:18:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] firmware: arm_scmi: check return value of idr_find
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190309040239.32431-1-kjlu@umn.edu>
Date:   Fri, 22 Mar 2019 21:18:19 -0500
Cc:     pakki001@umn.edu, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <55DFE6B7-B936-4F15-98C0-69F425D51665@umn.edu>
References: <20190309040239.32431-1-kjlu@umn.edu>
To:     kjlu@umn.edu
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 8, 2019, at 10:02 PM, Kangjie Lu <kjlu@umn.edu> wrote:
>=20
> idr_find may return NULL, so check its return value and return an
> error code.

Can someone review this patch? Thanks.

>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/firmware/arm_scmi/driver.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/firmware/arm_scmi/driver.c =
b/drivers/firmware/arm_scmi/driver.c
> index 8f952f2f1a29..35faa203d549 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -709,6 +709,8 @@ scmi_mbox_chan_setup(struct scmi_info *info, =
struct device *dev, int prot_id)
>=20
> 	if (scmi_mailbox_check(np)) {
> 		cinfo =3D idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
> +		if (!cinfo)
> +			return -EINVAL;
> 		goto idr_alloc;
> 	}
>=20
> --=20
> 2.17.1
>=20

