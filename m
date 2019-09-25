Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03CCC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC01620640
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406058AbfIYNHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:07:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:43240 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405791AbfIYNHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:07:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 06:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="390203184"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 25 Sep 2019 06:07:32 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iD711-0004jE-Em; Wed, 25 Sep 2019 16:07:31 +0300
Date:   Wed, 25 Sep 2019 16:07:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm, vmpressure: Fix a signedness bug in
 vmpressure_register_event()
Message-ID: <20190925130731.GL5933@smile.fi.intel.com>
References: <20190925110449.GO3264@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925110449.GO3264@mwanda>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 02:04:49PM +0300, Dan Carpenter wrote:
> The "mode" and "level" variables are enums and in this context GCC will
> treat them as unsigned ints so the error handling is never triggered.
> 
> I also removed the bogus initializer because it isn't required any more
> and it's sort of confusing.
> 

Indeed, assembly code is different.
Thank you for catching this!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 3cadfa2b9497 ("mm/vmpressure.c: convert to use match_string() helper")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  mm/vmpressure.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> index f3b50811497a..fe077500cf20 100644
> --- a/mm/vmpressure.c
> +++ b/mm/vmpressure.c
> @@ -362,7 +362,7 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
>  	struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
>  	struct vmpressure_event *ev;
>  	enum vmpressure_modes mode = VMPRESSURE_NO_PASSTHROUGH;
> -	enum vmpressure_levels level = -1;
> +	enum vmpressure_levels level;
>  	char *spec, *spec_orig;
>  	char *token;
>  	int ret = 0;
> @@ -376,7 +376,7 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
>  	/* Find required level */
>  	token = strsep(&spec, ",");
>  	level = match_string(vmpressure_str_levels, VMPRESSURE_NUM_LEVELS, token);
> -	if (level < 0) {
> +	if ((int)level < 0) {
>  		ret = level;
>  		goto out;
>  	}
> @@ -385,7 +385,7 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
>  	token = strsep(&spec, ",");
>  	if (token) {
>  		mode = match_string(vmpressure_str_modes, VMPRESSURE_NUM_MODES, token);
> -		if (mode < 0) {
> +		if ((int)mode < 0) {
>  			ret = mode;
>  			goto out;
>  		}
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


