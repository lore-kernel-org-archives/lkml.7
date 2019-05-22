Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE3EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285FF20863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jakemoroni.com header.i=@jakemoroni.com header.b="ZFbm55Ml";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LM5XhQMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfEVRfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:35:17 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52317 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbfEVRfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:35:17 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D008120CB3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:35:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 22 May 2019 13:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jakemoroni.com;
         h=from:content-type:content-transfer-encoding:mime-version:date
        :subject:message-id:to; s=fm3; bh=FfV+FE6CldNSY2p0Xo3j+sgr/sGrsY
        uQuZTfRHU1Rg8=; b=ZFbm55Ml4AMlcXK2AZTJSFZAK3AbbmfXFxpzj2cDu8x+Cb
        sN2tM5rtuV5qlBUW7lltfMpkjrgszh2JsV/v9GNptu2gY+pfBHdlryHDujsxgOpP
        SU4dExVbzQq2EcDgDGa8SlPzN85fqOuAoq7ZZW3Vnp+FWnV4QHPP4XGPDia0WIBx
        Gyf/3kPovQrquvl8IQy7sEB5VVWqtm5puj5JaL/OjHCcXxy+fFCHl9U4z+QjeFzd
        mQvyXf/yIPqsiKkQmZ2YNRx81Ls2ezq2VPMRKlHNsri9MW6qL99ZqYU0Wo1kP8rj
        FmlC76zxeCw5xVfAIpWe9YCO9SS+54Hag5xZ7Cvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FfV+FE
        6CldNSY2p0Xo3j+sgr/sGrsYuQuZTfRHU1Rg8=; b=LM5XhQMoZWGKrGc2cTx+v6
        kia4Gm4AYSIDcCLMSEO/qzk9Oy1GUoY/p1WXrtVo8eUHN5trzXeecGHyFJI5FFpK
        0UDexXIuzeejqcnw/7rxLxB+qr6qLl7oVjat9OYzzvtqXaWFpP/V+yl0ekszO6uS
        nfy3NPujcaj9uYxwZgrMPoizZ+l3urXKjWu9tyOpO5zDo2dm9nvzGNM5PEt2Dxzv
        8ENcEpaCW4N7NlkEhi3iucP6/vPPY9y4zFo3mRcyPWqQJ6bEnjA6+2+PiTE7tefC
        8BylCAmAXuss511cV2K7X0Zm3LHTroWvtPAOLgxLlpDlJ94jeozZD90l4PCQsbxQ
        ==
X-ME-Sender: <xms:U4jlXHcHFXDeZ6Xs-4A8UPoP64n90FgF8hpZbMl3TM5gug46qwG-Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudduvddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephfgtgfggfffukffvofesthhqmh
    dthhdtjeenucfhrhhomhepfdflrggtohgsucfurdcuofhorhhonhhifdcuoehmrghilhes
    jhgrkhgvmhhorhhonhhirdgtohhmqeenucfkphepudejvddrheekrddvtdefrddvkeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrihhlsehjrghkvghmohhrohhnihdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:U4jlXF-vvjR2ucIA1sNnzHJmKLcDhUa3KkhB2dRr6nOyQBou9_Ggvw>
    <xmx:U4jlXCs7ycXW-EAqfW8hzqga9VqnTog7SnIdA4WSDb5iRVIX4woxYQ>
    <xmx:U4jlXPyJPZcFS8Q-MoFuBnNry7mEBZ3uR7cxi98xnZnQodUNmJGKmA>
    <xmx:U4jlXNObIIwD7E0M4qVCf-8Qr1cI39LacpvkhLOqmQsINx4CZXnJkw>
Received: from [IPv6:2607:fb90:62b2:c453:e196:235f:f8b5:5298] (unknown [172.58.203.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1CEBD80065
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:35:15 -0400 (EDT)
From:   "Jacob S. Moroni" <mail@jakemoroni.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date:   Wed, 22 May 2019 13:35:14 -0400
Subject: Re: Linux 4.19.45
Message-Id: <B288C346-785F-4453-A2BC-69A7C13CD328@jakemoroni.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (16E227)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

4.19.45 doesn=E2=80=99t seem to build for me.

I get an error on line 1231 of fs/open.c regarding a missing definition for =E2=
=80=9CFMODE_STREAM=E2=80=9D.

I searched the entire tree for this definition and couldn=E2=80=99t find it d=
efined anywhere.

Thanks,
Jake Moroni

