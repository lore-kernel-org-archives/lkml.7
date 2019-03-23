Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4582BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0875A218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pQ7uV6On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfCWCht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:37:49 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:50360 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfCWChs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 22:37:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 5A29BCF9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 02:37:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jjvYXlGhK-iM for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 21:37:47 -0500 (CDT)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 0F9B514E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 21:37:47 -0500 (CDT)
Received: by mail-pg1-f200.google.com with SMTP id o4so3808629pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 19:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hRLDp3eHP1YQunU1bMGe9cTpfaI5PpR1Bh0ZyFSjAi0=;
        b=pQ7uV6Onsfx0GT3rJP1LQ4ZM1iZvpmSIlziGNJZWzxHP3pMXGMlwPLEtbhl/pf44G6
         aENWs/U+oBdk5oAi6l2+LfFk+OOya0osA7+7jP8JbHpJ/wKuA1PmFDEuikZuMn3831ic
         s9Ys4CBdP4HbFLR+QJvgwXT9SXtZDvFgaKtJxhGBTmYwbnrHE9y7maG+lSbPcRGvFEho
         c+gbVjOcNg0QF/G0qKkxzh1ColuqH1H0d8GlyqnLNv4+fhR0IjnWnn6/hnIuNvJR0ynn
         un49BNn0BujlnTzUiGRMdm7upJ96+xuVFGHeAd9HbMnk3SimLAyNW+UHy/ykydWtMHxN
         sB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hRLDp3eHP1YQunU1bMGe9cTpfaI5PpR1Bh0ZyFSjAi0=;
        b=osqagFnfSyHqyE2UiPIteyI4N2cU1XwT9ixxFDGY/oWt74EuPRYqHXVMu8MLy67mxD
         oeI7jLAFCHTv5znCr29weyLcg818bUYP0hIg72vSJJ9aceReVWqAkjADJI78a7MixmjT
         MlBnwP+k47H2dVkAWCZNxnsynp0gj6ztTgkLZJWa4P5mVLmENBLWDLXzTbCivlAA3TJJ
         WR/arUUVE25hbH8WGTTlOJHSVObhXhN6jUSJI6WOO4bJqXpMWhfJKOr6XZkmeWcITvzl
         0xYLw4CuSeek2IRNISF1pPFRRGN6ljj311PkQvF7QzJA/MQqFDqJOZKTPnq921C9PwgK
         aoKw==
X-Gm-Message-State: APjAAAV1BQJ+jFhfGc3mRIxcIhH1wixMKcNiLN6whbyno6nHOjLHubfB
        lrE1clWPIKeX93gb7THjqPuoR5MCX1rWOWSkIj8FjSxOh5B+Xn14gJaPEj4gUB8CA1nRlEBDsIe
        xXDuWA7zVy8k1dJgpWSnvnTJZVEge
X-Received: by 2002:a63:c511:: with SMTP id f17mr12010067pgd.202.1553308666333;
        Fri, 22 Mar 2019 19:37:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykVx759qZlMFfY38Sa74cFFUNwBxWC0LVDBNc1bKdL2d2RyvjzbTMHRu6vzk4W1HgYWl43Dg==
X-Received: by 2002:a63:c511:: with SMTP id f17mr12010062pgd.202.1553308666135;
        Fri, 22 Mar 2019 19:37:46 -0700 (PDT)
Received: from [10.184.4.71] (host-173-230-104-21.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.21])
        by smtp.gmail.com with ESMTPSA id e123sm12644866pfe.35.2019.03.22.19.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 19:37:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] infiniband: cxgb4: fix a potential NULL pointer
 dereference
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <20190309051921.15212-1-kjlu@umn.edu>
Date:   Fri, 22 Mar 2019 21:37:46 -0500
Cc:     pakki001@umn.edu, Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC1E06D8-7817-4314-AAD4-434FEB8C4157@umn.edu>
References: <20190309051921.15212-1-kjlu@umn.edu>
To:     kjlu@umn.edu
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 8, 2019, at 11:19 PM, Kangjie Lu <kjlu@umn.edu> wrote:
>=20
> get_skb may fail and return NULL. The fix returns "ENOMEM"
> when it fails to avoid NULL dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/infiniband/hw/cxgb4/cm.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c =
b/drivers/infiniband/hw/cxgb4/cm.c
> index 8221813219e5..502a54d57e2c 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -1919,6 +1919,9 @@ static int send_fw_act_open_req(struct c4iw_ep =
*ep, unsigned int atid)
> 	int win;
>=20
> 	skb =3D get_skb(NULL, sizeof(*req), GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +

Can someone review this patch? Thanks.

> 	req =3D __skb_put_zero(skb, sizeof(*req));
> 	req->op_compl =3D htonl(WR_OP_V(FW_OFLD_CONNECTION_WR));
> 	req->len16_pkd =3D =
htonl(FW_WR_LEN16_V(DIV_ROUND_UP(sizeof(*req), 16)));
> --=20
> 2.17.1
>=20

