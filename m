Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B9AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B915D20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PPaAM3Ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDHLXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:23:35 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50186 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfDHLXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:23:35 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 1545E24E244A;
        Mon,  8 Apr 2019 04:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554722615; bh=rOIKKeKeK0MAxkfem91fHRt8KVPP23DVTooT2JAR3L4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PPaAM3OkvcDjf3D5hyIs4zVIoeGZnZXg1UKVsKXW6NhCfWuS4GKJYRkWqG15SYaTZ
         29jWtFuvm+JBBKjmDhMwdQ7cMkIdsovzDKyIJ9NJsHLC1gEX5t+t5phCs8+Wv+9pPV
         hZC2TIz2gdgRe5Zz//RmRyYlxc3ejvos3242H7F8waVeq/4vbISaeIskt5Otsys6hp
         qVZMCnFGpqRb42CCjw/7NJWKHJ+Kq7PKqSE2DPI1HOce6CqLLIZEjlT3KzxbwVb32u
         Td4ef77JWp8tbeKET5U1EkeeOaSTz0EbLSaY24YxQcBKNmwNF+XkQpATPIOvB71cRj
         Cg9M8mCYKTEdQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A4869A00A1;
        Mon,  8 Apr 2019 11:23:34 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 8 Apr 2019 04:23:34 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 8 Apr 2019 13:23:32 +0200
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     Vitor Soares <vitor.soares@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis de Oliveira <luis.oliveira@synopsys.com>,
        "Gustavo Pimentel" <gustavo.pimentel@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH] reset: axs10x: Implement assert and deassert callbacks
Thread-Topic: [PATCH] reset: axs10x: Implement assert and deassert callbacks
Thread-Index: AQHU7fY+jcVWLwjUokCR3yItmtJI/KYyHqxQ
Date:   Mon, 8 Apr 2019 11:23:31 +0000
Message-ID: <78EB27739596EE489E55E81C33FEC33A0B44FBB5@DE02WEMBXB.internal.synopsys.com>
References: <33ed7b90da8439aecb3544c3ff7dcfb511e03b8e.1554457026.git.vitor.soares@synopsys.com>
In-Reply-To: <33ed7b90da8439aecb3544c3ff7dcfb511e03b8e.1554457026.git.vitor.soares@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.107.19.176]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVml0b3IgU29hcmVzIDx2aXRvci5zb2FyZXNAc3lub3BzeXMuY29tPg0KRGF0ZTogTW9u
LCBBcHIgMDgsIDIwMTkgYXQgMTE6MzE6MjMNCg0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCByZXNl
dF9jb250cm9sX29wcyBheHMxMHhfcmVzZXRfb3BzID0gew0KPiAtCS5yZXNldAk9IGF4czEweF9y
ZXNldF9yZXNldCwNCg0KRXVnZW5peSwgQWxleGV5LA0KDQpJIHRoaW5rIHRoZSBpbXBsZW1lbnRh
dGlvbiBvZiB0aGlzIGNhbGxiYWNrIGlzIHdyb25nOiB5b3Ugc2hvdWxkDQpyZWFkbF9wb2xsX3Rp
bWVvdXRfYXRvbWljKCkgdW50aWwgdGhlIHJlc2V0IGJpdCBpcyBub3QgY2xlYXJlZC4NCg0KVGhh
bmtzLA0KSm9zZSBNaWd1ZWwgQWJyZXUNCg==
