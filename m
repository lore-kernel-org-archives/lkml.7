Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623CCC4320D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DEC20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JtP0Z7Fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503033AbfIWVt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:49:27 -0400
Received: from sonic304-16.consmr.mail.bf2.yahoo.com ([74.6.128.39]:34096 "EHLO
        sonic304-16.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389663AbfIWVt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1569275365; bh=VAFmE/6tXGPxBsXYIK0wBVihKxfSEFCW00XTJ1PUz3w=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=JtP0Z7FijijcTEGgI4CozQAWRLPKM5nY4MzBdrAiCGNkFQePSLAWWDp+4HwVC2SvuL3zQ5u3GNjIIuil7CKCm0XcmNWUkdyok9C72d/PdxvwDw7ZrcTtJ9mBSUWU7yTsRAFv0tqWLZiC9Vx8lllSXhXoccNOl9Qg5VK1/U4OrlB/5MjCwJNS1uoTK1UAo6H9SHotuIxv0BTK1KfV41xUgrs79urGi2hZJJDSBywMb2L23MP8y06eOFsGBy7Pr0mkkr6/cFIwRygcXqiEpU+GkwfttbC+q2DTjgn4ATvQDZbM/t3BqKJt/sxrFnnXdL8b1ZBzUOnocI92W/IwH2n7Jg==
X-YMail-OSG: 2sxVsJYVM1kKDgTIKNslz0P9BR7FpJrxm0wDwMmQS6FRGMrHO7yR1H6d7O7uyL_
 C_5zgQJddr5Ol9rPtYqqBBEoUwyzDQHOTgxmxKCNrXJ9C6vMdWka8V32qbLkrDtaMa1WQiP0eBi5
 lKjoiEoikjKfrxsO6Pgtaa_Ko8spSknO4OlB4CdbfN2kfrbnlHEshXoLphMk0HIO1jFmICvG4gGI
 Kh_pXsv8kL8wX9eJxEZX.FDsvHpsxRxDywGdQyZQZnnaFM7wqMUYvxusFTyF0j0vr_fRHdIj5Nb8
 YxRYKG2UKa1ilXI6AVYo3IdCL54I66Y2aO0PqMndnqKMioY5YqmoODidsAJlkDuQKqhpV97YhubZ
 gvugwZHEHvXjqoHrkU1slNRrMStuDRsDqusYLJ7RvmY_kEowKnzI3wKVwbGqo.2HpSZ7Eb0NM7og
 t1XA21QXSkIzsYDYpOugHis9Jm_y4cwMV_iyF_Y93xUWn_5ZyNLBRANVkQE.qznysK7b.1jrwcfS
 zQ_5Y7tPprNWFN2nPT34.3h0oP6d63ObXMAmMcfpUVZnLgZA6hEt09mEVWtw5fM6tUwp8WUx9Fjy
 syZzFOk.t9_XgKLAAAx0lbmOzGfg5d1g14m0gFhKu2.4qKgIqBkBu3GOwruvmQb9NSwCCPVcm.Cu
 vpvTWRaW7INhuQ0gOJImJ662IDPigIwUWmAkYSjpIgp0CyZzKcnxGoXd3sBuLU1RzJjbiCPEKD3f
 1.LeiFxRP5EMf0_5EwSDVV0xNKbandghaRltv2YxmOH7oYIFISRw1QejhUMwfIRKePqeNxxkgS5v
 Td6EHcwRzEiv95FfZb0VHrpYBsV7ErsW2tjUpUOMHI_85tK1eaZXboX_az4wRIJs4aFfpHfFl1JJ
 9f0WC8.EAv_HNoJ6bNsAhs0e9Wj6fWgpo9wIDb.UWUIWKWaCvNDCwKIuzPWuHDJZbXSJzfEHUg6g
 1X0WeYfEFBzKTMqlW.HAQBeGuzB8zajzeaM9PEEI0RoGiX5H9rhJPZD8BBIFv3j0XRBAOvujSLWE
 SVaj7915qfQ.VACrIG_hzUi8AfcWWNVqa5yQhOmXkVKVhKRV7yYmsLAUB_g07dSJ291eb5Bd5jvm
 25vepsfCqLfCczjwgvJE9j4ux_zulIxp_Z.Z7FQiL6QtFVl75ltBhOMlcfU5k5wiFN9i1Qkg.2Zv
 vAbgNuWxgxHG_fueIkF8CbNzQQontaQFDgvkXqE8pSS9QPA6TvUm65zK8553PXkcgX8Ud2AVzL6d
 o1LGvlsOYBQtXDlVg3.GJCWffgM6osQJRefnJJnbzgrofIKe1aEyvoEWKvfD.twG49Y6MvCDeHZr
 jkxDSIT0kkWo3zRY.8ijM_jRQ8NbzV_U-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Mon, 23 Sep 2019 21:49:25 +0000
Received: by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e2e0ca6a7293cb639b2f6ef594400203;
          Mon, 23 Sep 2019 21:49:23 +0000 (UTC)
Subject: Re: [PATCH] smack: fix an compile error in smack_post_notification
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1569208607-23263-1-git-send-email-zhongjiang@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <4e3513ac-3398-5d21-a2b2-3006ba03a690@schaufler-ca.com>
Date:   Mon, 23 Sep 2019 14:49:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1569208607-23263-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2019 8:16 PM, zhong jiang wrote:
> I hit the following error when compile the kernel.

What tree/branch are you working with? I don't see this.

>
> security/smack/smack_lsm.c: In function smack_post_notification:
> security/smack/smack_lsm.c:4383:7: error: dereferencing pointer to incomplete type struct watch_notification
>   if (n->type == WATCH_TYPE_META)
>        ^~
> security/smack/smack_lsm.c:4383:17: error: WATCH_TYPE_META undeclared (first use in this function); did you mean TCA_PIE_BETA?
>   if (n->type == WATCH_TYPE_META)
>                  ^~~~~~~~~~~~~~~
>                  TCA_PIE_BETA
> security/smack/smack_lsm.c:4383:17: note: each undeclared identifier is reported only once for each function it appears in
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  security/smack/smack.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 62529f3..02b05a2 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -21,6 +21,7 @@
>  #include <linux/rculist.h>
>  #include <linux/lsm_audit.h>
>  #include <linux/msg.h>
> +#include <linux/watch_queue.h>
>  
>  /*
>   * Use IPv6 port labeling if IPv6 is enabled and secmarks
