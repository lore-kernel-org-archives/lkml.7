Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B33C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F2B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555394178;
	bh=LaZg30p3LT3/qmY6KjsGymjyxExVucxjEZ/L30zMURw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r6Gc+IJbr410uUxs4QD8BpMlGTe+lBqHF+bdBf+525bnvFDyKgX+SxsKjjs6tv7k0
	 g2ASyq5p45qQwjJjco74Mpmr/+Bo0eq1/+qj77w0j4CzgGXMi8AqOWYkbRRtQU4AJP
	 5KDB/0abc65ss5H3XbySnfPHDZn0iIjrCn+dXLXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfDPF4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfDPF4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:56:16 -0400
Received: from X250.skyworth_vap (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BFD2075B;
        Tue, 16 Apr 2019 05:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555394176;
        bh=LaZg30p3LT3/qmY6KjsGymjyxExVucxjEZ/L30zMURw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dXIq5AeZwRgLocf08Xq7PzDtwakUT31ato9l289AbDVTezmQuAEPMLa2upSmMxh4d
         D6j7qxrlFOezCULNR++eZzNoP9wAhs6Is8xvd+KprLl/xVjoutrm0fknhiReiQLZyC
         gZKCWgOnfH2SW4LIxC64VGV3IKtZJbfvy2yHx+ec=
Date:   Tue, 16 Apr 2019 13:56:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Linus Walleij <linus.walleij@linaro.org>,
        Jun Nie <jun.nie@linaro.org>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 5/5] pinctrl: zte: fix leaked of_node references
Message-ID: <20190416055601.GB4690@X250.skyworth_vap>
References: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn>
 <1555048943-39589-6-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555048943-39589-6-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 02:02:23PM +0800, Wen Yang wrote:
> The call to of_parse_phandle returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./drivers/pinctrl/zte/pinctrl-zx.c:415:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
> ./drivers/pinctrl/zte/pinctrl-zx.c:422:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
> ./drivers/pinctrl/zte/pinctrl-zx.c:436:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
> ./drivers/pinctrl/zte/pinctrl-zx.c:444:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
> ./drivers/pinctrl/zte/pinctrl-zx.c:448:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 407, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>
