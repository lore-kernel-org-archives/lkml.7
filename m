Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D72CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FD7208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.net header.i=@jaseg.net header.b="Sbq1rGrJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fy+g7haM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbfG3NsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:48:15 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33143 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731505AbfG3NsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:48:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D8EE2177A;
        Tue, 30 Jul 2019 09:48:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2019 09:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.net; h=
        from:subject:to:cc:in-reply-to:message-id:date:mime-version
        :content-type:content-transfer-encoding; s=fm3; bh=BV5udAWkY68a8
        1lrXbHWDnn+Gj2t2NQYxWIA3zsL6uE=; b=Sbq1rGrJoNq6CFknKZCn4G+tvR+fT
        G3YYv/t7RWG7DiLouptH7h6Hk9aAS3KlufHONsf2E2s7mWXccis3CxZ0C2df+rdn
        gMAw5/0up+kHOK059ph69R7KKpoxLBJsZDDM+krjnLDJeuKh45Zf2mB+fiU7TY2A
        2a/h5VsnaJfaCKQFhrz8UKYxoK3/Kq3pgZrWdLVo2I5gNYUsJLDGuO1y5QZCZiOv
        6ZRpspcuFsuboEHrEmr6822752famJWWGxkxKSlK+85T2jxLLlq6Df6edA5aQ4Am
        ZZZ7lE6oLwqowcnEof/HWbypKKFY2Wq2YH/gkkXzWsxRYnhlEUzAJ95IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=BV5udAWkY68a81lrXbHWDnn+Gj2t2NQYxWIA3zsL6uE=; b=fy+g7haM
        v79C6qaq1t8vu0FhJUhFDCzf5altlp1xfpjygD5OKysJ5FmgB0vf68rFyU5pi2wJ
        HNBLu+o1LntrjpZ6SvmBB1Zuxr0M4AJBhHFq0qp0LX2wli7Jp2JQNruDzkPY+rJz
        yhrMUS6Kl5eQ+uhyvzDaaCEaE3FCZjLxXOvnZ5orG5bv8iM6FeoTzy6TDFjZV6U8
        k4cLHA5IiW6q0wC7ZPsYiiBp0v6QguGrTZreWjh4ZR/Uaa/+o7qlKGtCgsnxsWHu
        k5JK5P+bd9gkD9aOy9JSEHh02m6RehxoXLGaK99//zLsMtu/VHnEm1cKHHbgTNEE
        75lEz652D3brdw==
X-ME-Sender: <xms:nUpAXTvQYK6YMIB7uevrFdWJ2VvfvgkfDhiNIm1OVkPQmQzK_osDFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhuffvjgfkffgfgggtgfesthekredttdefjeenucfhrhhomheplfgrnhgpufgv
    sggrshhtihgrnhgpifpnthhtvgcuoehlihhnuhigsehjrghsvghgrdhnvghtqeenucfkph
    epiedtrdejuddrieefrdejheenucfrrghrrghmpehmrghilhhfrhhomheplhhinhhugies
    jhgrshgvghdrnhgvthenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:nUpAXa7Me2QnPqiZdemfqW5Luv37tL0IJOPmEGzMJ-wFf8a3JLRY9A>
    <xmx:nUpAXUQuEWF6TdyIEOHAXdD24X3XbqVzk_Z9ZtH01tYzuAN2-eqsIw>
    <xmx:nUpAXanYS-G5WQ-_ypICJU-L2mUbSsnKE8BSQ5Ggs6RktkLpDc5lCg>
    <xmx:nUpAXU3eR-E1J3LHvJqyT53iUXWdmLY77sALuYg6BPs6EA2ed2_6BA>
Received: from [10.137.0.16] (softbank060071063075.bbtec.net [60.71.63.75])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1911880061;
        Tue, 30 Jul 2019 09:48:11 -0400 (EDT)
From:   =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Subject: [PATCH 2/6] dt-bindings: add gooddisplay vendor prefix
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
In-Reply-To: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
Message-ID: <6bab6d9d-135b-426f-738d-f5ef5bba3453@jaseg.net>
Date:   Tue, 30 Jul 2019 22:48:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dalian Good Display Co., Ltd. among others makes three-color epaper
panels.

Signed-off-by: Jan Sebastian Götte <linux@jaseg.net>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 33a65a45e319..fae6da6cd77d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -339,6 +339,8 @@ patternProperties:
     description: GlobalTop Technology, Inc.
   "^gmt,.*":
     description: Global Mixed-mode Technology, Inc.
+  "^gooddisplay,.*":
+    description: Dalian Good Display Co., Ltd.
   "^goodix,.*":
     description: Shenzhen Huiding Technology Co., Ltd.
   "^google,.*":
-- 
2.21.0

