Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E8C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A65217AB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="aBzMWWaD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eezsrJTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfK1WbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:31:12 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55623 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726582AbfK1WbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 17:31:12 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D3F32248F;
        Thu, 28 Nov 2019 17:31:11 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 28 Nov 2019 17:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Z6N2dtUd2b7xlsWo9+75kmAEXEFh/6k
        k7C70gDaO+IM=; b=aBzMWWaDQCaZLJCWK/tAw01tr3vOY/rqWJff6yXoSV/X9qn
        9CzQ/MqA+67y5kYqX53mWISFWnpTTlSpvewPe0kSFrgodvz9YqQeItgLhO/XrQQj
        HZci78+K9MLZ3aNSbCIVL4qNzyWmJWlxfbrEyenmED7Crk+hkyrj02uCVJuaPO18
        v18H1bkSngAmaj/rB8SnDPKzRUA55KAMBwSJWYv6wEZzOAzoEKS0/gICVyrI+fKd
        8ECz4DCSa4nQfNbF0+SX8fQto9FSDjjh28FacyBOi/ywSAaENPAgamzAp4g+SCtR
        50vQ69r9KxBUg4RiDa15/D6e+ibpIBpzCzTCqWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Z6N2dt
        Ud2b7xlsWo9+75kmAEXEFh/6kk7C70gDaO+IM=; b=eezsrJTWk/l1M181fX92RG
        iS6UGzEkbjvsb+taMY2YV3cp4823HLxlWZPf1lWwjZ3Ns0PTnXzVwkcG2yEznCRV
        88GSa7o8HeyN4kMYVomvCPxT9lIK2cPCZ7QUwhhs7orPz6vixP++Lcqf6HkSTfbu
        cf49v/PVtvpVkfV496wckmwwE4rHvmQch6O4ChOBWnskjElcdb0jafyByM6xyfzN
        OXGSnrbGTTM9swrwXKRGhzDZp62qo3wzhFRJr8MWV+PzsidlBy0XYqZNp3Ro/7A6
        T5/kIGbfl0dltb/cg437o3+EyJSHxRjV6bDwgGgiQPXmB2ys8fmbmQZD3bDzwWIg
        ==
X-ME-Sender: <xms:rUrgXU8te6J8t4RnEp7OG_oCn-7XRY8MuBrrjmMMApd8Y1cXkAqurw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeijedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:rUrgXYjDHS8a48sSg-3a8zqRQIlr_IMWEeYy-XSlWoPbwAnPaLG-jg>
    <xmx:rUrgXRWflTlD87Ucw8_pnKmS3NQ1EZ1U7BhWTiSvZFRgJ3u5o96I0A>
    <xmx:rUrgXXt9iMxMBEvXYcMW3EMFqUbMg_e3d1FexpiSstq6GQE_wyLN3w>
    <xmx:r0rgXf_FXQQvLFD9kQYFTJEvjo8YdvbIIHok0EWDhEK3ATQeDIz6dg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4103FE00A2; Thu, 28 Nov 2019 17:31:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <a709068c-9375-4921-a87f-c5f3a1f63cf2@www.fastmail.com>
In-Reply-To: <20191122233120.110344-1-colin.king@canonical.com>
References: <20191122233120.110344-1-colin.king@canonical.com>
Date:   Fri, 29 Nov 2019 09:02:39 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Colin King" <colin.king@canonical.com>,
        "Jeremy Kerr" <jk@ozlabs.org>, "Joel Stanley" <joel@jms.id.au>,
        "Alistair Popple" <alistair@popple.id.au>,
        "Eddie James" <eajames@linux.ibm.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        linux-fsi@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH]_fsi:_fix_bogos_error_returns_from_cfam=5Fread_and_?=
 =?UTF-8?Q?cfam=5Fwrite?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Nov 2019, at 10:01, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where errors occur in functions cfam_read and cfam_write
> the error return code in rc is not returned and a bogus non-error
> count size is returned instead. Fix this by returning the correct
> error code when an error occurs or the count size if the functions
> worked correctly.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: d1dcd6782576 ("fsi: Add cfam char devices")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
