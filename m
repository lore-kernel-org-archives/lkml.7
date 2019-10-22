Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DCCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D605C21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HDCatmX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfJVTBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:01:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732843AbfJVTBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d9yg4mPEtKS509d8ZBOwLQ1kbG4IoNvuY2GLoSXTaG0=; b=HDCatmX9CuB1exuEpAt6Ae7v2
        yQy8dzbkcxVmLC+1eJhpPBu8jPsPtskVLQBVx6G2W+Dhk5lROTMwG53RD6S1id6X9FsRJVyXcf640
        SKaX++rbm7b2SJDw7EHyL+Ar04GWnGRj9ABwh5GzF3DfKo/TVTzW7uULCvveFlFEJIfkwqccO83Ah
        3HQ+zmG2M1v0Pnu6V1ZPWJElLLfweXvBkF9c4W65HdYFSpJBcGLB19zrBpWurIntk8sBtXVcCPswf
        D3H5YWKOaPWX9iE144PS8zqigGJF2nLVpSEfopIoZCjCRHd50nK8mmAx4ZZcZIxWSuhClHU1Hd/+u
        2u7RN0gtQ==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMzPg-0000Jt-Bd; Tue, 22 Oct 2019 19:01:48 +0000
Subject: Re: [PATCH] reset: improve of_xlate documentation
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20191022163024.17005-1-p.zabel@pengutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <64c30c47-454d-40a3-9112-4cda26fc3e79@infradead.org>
Date:   Tue, 22 Oct 2019 12:01:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022163024.17005-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
minor fix below:

On 10/22/19 9:30 AM, Philipp Zabel wrote:
> Mention of_reset_simple_xlate as the default if of_xlate is not set.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/core.c             | 6 ++++--
>  include/linux/reset-controller.h | 3 ++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 660e0b07feca..3066f12f70db 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -77,8 +77,10 @@ static const char *rcdev_name(struct reset_controller_dev *rcdev)
>   * @rcdev: a pointer to the reset controller device
>   * @reset_spec: reset line specifier as found in the device tree
>   *
> - * This simple translation function should be used for reset controllers
> - * with 1:1 mapping, where reset lines can be indexed by number without gaps.
> + * This static translation function is be used by default if of_xlate in

                              function is used by default

> + * :c:type:`reset_controller_dev` is not set. It is useful for all reset
> + * controllers with 1:1 mapping, where reset lines can be indexed by number
> + * without gaps.
>   */
>  static int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
>  			  const struct of_phandle_args *reset_spec)
> diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
> index 984f625d5593..c53626c07e87 100644
> --- a/include/linux/reset-controller.h
> +++ b/include/linux/reset-controller.h
> @@ -62,7 +62,8 @@ struct reset_control_lookup {
>   * @of_node: corresponding device tree node as phandle target
>   * @of_reset_n_cells: number of cells in reset line specifiers
>   * @of_xlate: translation function to translate from specifier as found in the
> - *            device tree to id as given to the reset control ops
> + *            device tree to id as given to the reset control ops, defaults
> + *            to :c:func:`of_reset_simple_xlate`.
>   * @nr_resets: number of reset controls in this reset controller device
>   */
>  struct reset_controller_dev {
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
