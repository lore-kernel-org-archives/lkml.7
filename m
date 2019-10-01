Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F7DC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E674F21906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbfJALPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:15:55 -0400
Received: from gofer.mess.org ([88.97.38.141]:57041 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfJALPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:15:55 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 2A59BC646D; Tue,  1 Oct 2019 12:15:53 +0100 (BST)
Date:   Tue, 1 Oct 2019 12:15:53 +0100
From:   Sean Young <sean@mess.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     mchehab@kernel.org, hansverk@cisco.com, daniel.vetter@ffwll.ch,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] media: dvb-frontends: Use DIV_ROUND_CLOSEST directly
 to make it readable
Message-ID: <20191001111552.GA18622@gofer.mess.org>
References: <1567700092-27769-1-git-send-email-zhongjiang@huawei.com>
 <1567700092-27769-2-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567700092-27769-2-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 06, 2019 at 12:14:49AM +0800, zhong jiang wrote:
> The kernel.h macro DIV_ROUND_CLOSEST performs the computation (x + d/2)/d
> but is perhaps more readable.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/media/dvb-frontends/mt312.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-frontends/mt312.c b/drivers/media/dvb-frontends/mt312.c
> index 7cae7d6..251ff41 100644
> --- a/drivers/media/dvb-frontends/mt312.c
> +++ b/drivers/media/dvb-frontends/mt312.c
> @@ -137,7 +137,7 @@ static inline int mt312_writereg(struct mt312_state *state,
>  
>  static inline u32 mt312_div(u32 a, u32 b)
>  {
> -	return (a + (b / 2)) / b;
> +	return DIV_ROUND_CLOSEST(a, b);

Well spotted, that is absolutely correct. However now mt312_div() is just
a wrapper for DIV_ROUND_CLOSEST() -- and even marked inline. Really all
the callers to mt312_div() should be replaced with DIV_ROUND_CLOSEST().

Thanks,

Sean
