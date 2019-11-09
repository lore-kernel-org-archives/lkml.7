Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF7EC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 09:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F7021848
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 09:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfKIJTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 04:19:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58162 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKIJTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 04:19:19 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTMtl-0001iB-NT; Sat, 09 Nov 2019 09:19:13 +0000
Date:   Sat, 9 Nov 2019 09:19:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     gregkh@linuxfoundation.org, jerome.pouiller@silabs.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Boqun.Feng@microsoft.com
Subject: Re: [PATCH] staging: wfx: add gcc extension __force cast
Message-ID: <20191109091913.GV26530@ZenIV.linux.org.uk>
References: <20191108233837.33378-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108233837.33378-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 11:38:37PM +0000, Jules Irenge wrote:
> Add gcc extension __force and __le32 cast to fix warning issued by Sparse tool."warning: cast to restricted __le32"
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/staging/wfx/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wfx/debug.c b/drivers/staging/wfx/debug.c
> index 0a9ca109039c..aa7b2dd691b9 100644
> --- a/drivers/staging/wfx/debug.c
> +++ b/drivers/staging/wfx/debug.c
> @@ -72,7 +72,7 @@ static int wfx_counters_show(struct seq_file *seq, void *v)
>  		return -EIO;
>  
>  #define PUT_COUNTER(name) \
> -	seq_printf(seq, "%24s %d\n", #name ":", le32_to_cpu(counters.count_##name))
> +	seq_printf(seq, "%24s %d\n", #name ":", le32_to_cpu((__force __le32)(counters.count_##name)))

NAK.  force-cast (and it's not a gcc extension, BTW - it's sparse) is basically
"I know better; the code is right, so STFU already".  *IF* counters.count_...
is really little-endian 32bit, then why isn't it declared that way?  And if
it's host-endian, you've just papered over a real bug here.

As a general rule "fix" doesn't mean "tell it to shut up"...
