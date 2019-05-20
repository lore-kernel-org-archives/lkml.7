Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B92C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA44D20675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbfETJjY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:39:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:42592 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfETJjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:39:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 02:39:23 -0700
X-ExtLoop1: 1
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2019 02:39:21 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-kernel@vger.kernel.org
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [RESEND PATCH] intel_th: msu: Fix unused variable warning on arm64 platform
In-Reply-To: <1558333597-63774-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1558333597-63774-1-git-send-email-zhangshaokun@hisilicon.com>
Date:   Mon, 20 May 2019 12:39:21 +0300
Message-ID: <87woilwjli.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shaokun Zhang <zhangshaokun@hisilicon.com> writes:

> drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_alloc’:
> drivers/hwtracing/intel_th/msu.c:783:21: warning: unused variable ‘i’ [-Wunused-variable]
>   int ret = -ENOMEM, i;
>                      ^
> drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_free’:
> drivers/hwtracing/intel_th/msu.c:863:6: warning: unused variable ‘i’ [-Wunused-variable]
>   int i;
>       ^
> Fix this compiler warning on arm64 platform.

Thank you for taking care of this.

> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/hwtracing/intel_th/msu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
> index 81bb54fa3ce8..833a5a8f13ad 100644
> --- a/drivers/hwtracing/intel_th/msu.c
> +++ b/drivers/hwtracing/intel_th/msu.c
> @@ -780,7 +780,10 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
>  static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
>  {
>  	struct msc_window *win;
> -	int ret = -ENOMEM, i;
> +	int ret = -ENOMEM;
> +#ifdef CONFIG_X86
> +	int i;
> +#endif

Can you factor it out into its own function? And one for the other
memory type? So we can maybe keep it to just one #ifdef like

#ifdef CONFIG_X86
void msc_buffer_set_uc()
{ ... }
void msc_buffer_set_wb()
{ ... }
#else /* !X86 */
static void msc_buffer_set_uc() {}
static void msc_buffer_set_wb() {}
#endif

Thanks,
--
Alex
