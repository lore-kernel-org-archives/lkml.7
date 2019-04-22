Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89786C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EEA20896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555965684;
	bh=MKOufmg1gp0O5MF4o/zzBGJXUoOn07OxqaP+2YdDMi0=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=DmT9wqAAsQUhnlZCU5W+gqxhb3xD4C+1AZGVX1ahFew0ziGT2jKCVfSNFyYXueNoN
	 K7HZh44QU9M5bSFjbXb30lEfIaA1Mm575w8WV8zAuZq9LVO8f+EKBsl/kJhbMgBoOb
	 szJYL27mZSxaWrVHCAT2RthvZ++i4ymCy5bkGMYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfDVUlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbfDVUlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 16:41:22 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BA4920859;
        Mon, 22 Apr 2019 20:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555965682;
        bh=MKOufmg1gp0O5MF4o/zzBGJXUoOn07OxqaP+2YdDMi0=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=kxgumhRqRdq5kUorCyX04QcQx6qluoRWT5qvllqpTD0JBlIbHj1bwfSuuE8KJU65j
         0wc4gws1YhDHsUspgM2U5jn/6Qk1jfL7lDZhVkVCz/owNHzzNfpXAHxfMpyfJxa372
         BtLBtUJc7Wyq1L+XiJikwdBxNAtaT9vActzKf6A0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aede2c05c333fd599252a74e67904ff7847b0dcf.1555921081.git.leonard.crestez@nxp.com>
References: <cover.1555921081.git.leonard.crestez@nxp.com> <aede2c05c333fd599252a74e67904ff7847b0dcf.1555921081.git.leonard.crestez@nxp.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/3] scripts/gdb: Add hlist utilities
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Message-ID: <155596568158.15276.10057207756258850078@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 22 Apr 2019 13:41:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leonard Crestez (2019-04-22 01:26:56)
> This allows easily examining kernel hlists in python.
>=20
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

> +
> +
> +def hlist_for_each_entry(head, gdbtype, member):
> +    for node in hlist_for_each(head):
> +        if node.type !=3D hlist_node.get_type().pointer():
> +            raise TypeError("Type {} found. Expected struct hlist_head *=
."

Maybe drop the full-stop? It looks weird to see struct list_head *.

> +                            .format(node.type))
> +        yield utils.container_of(node, gdbtype, member)
> +
> +
