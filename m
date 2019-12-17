Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D843C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BC521835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rB6gSozd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfLQQDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:03:06 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54248 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQQDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:03:06 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHG34hB001199;
        Tue, 17 Dec 2019 10:03:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576598584;
        bh=QYwTpwifRMELPvhXhsHprKDYNR9CWvyjKqDNddNlTbk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rB6gSozdKXwwn8e+Mi3unuPKgTdTp/OmoJ8QGDXEP/jzeX/8MgurAN6YmXFUPA0b9
         8lRGzbfti6v6EZXBL3igNXYV5ZbbCwDqC9L8bMc0Run+di/xTa/um0fIPEvBMlWhkP
         FQKlV6+M9JwCYsmRtgAQyFve5jlN2cXLrIRZpEuM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHG34R1036086
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 10:03:04 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 10:03:03 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 10:03:03 -0600
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with SMTP id xBHG33b5070029;
        Tue, 17 Dec 2019 10:03:03 -0600
Date:   Tue, 17 Dec 2019 10:06:29 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Maxime Ripard <mripard@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] dtc: checks: check_graph_port: skip node name check in
 overlay case
Message-ID: <20191217160629.6iwpnd4p6glxbohg@ti.com>
References: <20191122191631.2382-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191122191631.2382-1-bparrot@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping!

Benoit Parrot <bparrot@ti.com> wrote on Fri [2019-Nov-22 13:16:31 -0600]:
> In check_graph_port() we need to skip the node name check in the overlay
> case as it causes a false positive warning.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  checks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/checks.c b/checks.c
> index 756f0fa9203f..6b6712da146a 100644
> --- a/checks.c
> +++ b/checks.c
> @@ -1707,7 +1707,8 @@ static void check_graph_port(struct check *c, struct dt_info *dti,
>  	if (node->bus != &graph_port_bus)
>  		return;
>  
> -	if (!strprefixeq(node->name, node->basenamelen, "port"))
> +	if (!strprefixeq(node->name, node->basenamelen, "port") &&
> +	    !(dti->dtsflags & DTSF_PLUGIN))
>  		FAIL(c, dti, node, "graph port node name should be 'port'");
>  
>  	check_graph_reg(c, dti, node);
