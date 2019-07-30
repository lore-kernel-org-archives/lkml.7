Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202BFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F80208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfG3QfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:35:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:32978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbfG3QfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:35:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45EB2AC9B;
        Tue, 30 Jul 2019 16:35:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DCA0B1E4370; Tue, 30 Jul 2019 18:34:58 +0200 (CEST)
Date:   Tue, 30 Jul 2019 18:34:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: fix condition for resetting time limit in
 do_set_dqblk()
Message-ID: <20190730163458.GI28829@quack2.suse.cz>
References: <20190724053216.19392-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724053216.19392-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-07-19 13:32:16, Chengguang Xu wrote:
> We reset time limit when current usage is smaller
> or equal to soft limit in other place, so follow
> this rule in do_set_dqblk().
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks! Applied.

								Honza

> ---
>  fs/quota/dquot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index be9c471cdbc8..6e826b454082 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2731,7 +2731,7 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>  
>  	if (check_blim) {
>  		if (!dm->dqb_bsoftlimit ||
> -		    dm->dqb_curspace + dm->dqb_rsvspace < dm->dqb_bsoftlimit) {
> +		    dm->dqb_curspace + dm->dqb_rsvspace <= dm->dqb_bsoftlimit) {
>  			dm->dqb_btime = 0;
>  			clear_bit(DQ_BLKS_B, &dquot->dq_flags);
>  		} else if (!(di->d_fieldmask & QC_SPC_TIMER))
> @@ -2740,7 +2740,7 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>  	}
>  	if (check_ilim) {
>  		if (!dm->dqb_isoftlimit ||
> -		    dm->dqb_curinodes < dm->dqb_isoftlimit) {
> +		    dm->dqb_curinodes <= dm->dqb_isoftlimit) {
>  			dm->dqb_itime = 0;
>  			clear_bit(DQ_INODES_B, &dquot->dq_flags);
>  		} else if (!(di->d_fieldmask & QC_INO_TIMER))
> -- 
> 2.20.1
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
