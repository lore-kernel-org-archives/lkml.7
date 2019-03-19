Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907F320854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCSIxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:53:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:36160 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfCSIxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:53:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 905CDAED8;
        Tue, 19 Mar 2019 08:53:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1A3AE1E428E; Tue, 19 Mar 2019 09:52:59 +0100 (CET)
Date:   Tue, 19 Mar 2019 09:52:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Jan Kara <jack@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: Fix to check the return value of load_nls
Message-ID: <20190319085259.GD17334@quack2.suse.cz>
References: <20190319025950.18311-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319025950.18311-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-03-19 21:59:49, Aditya Pakki wrote:
> load_nls may fail and return an error message. The patch checks
> for such a scenario and passes the error upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Thanks for the patch! But there's other code handling nls_map in
udf_fill_super() which takes care about this situation:

        if ((uopt.flags & (1 << UDF_FLAG_NLS_MAP)) && !uopt.nls_map) {
                uopt.nls_map = load_nls_default();
                if (!uopt.nls_map)
                        uopt.flags &= ~(1 << UDF_FLAG_NLS_MAP);
                else
                        udf_debug("Using default NLS map\n");
        }

So if we failed to load nls map admin originally requested, we fall back to
a default nls map or just don't load anything. It is questionable whether
we shouldn't fail mount rather than trying to continue with a different nls
map but at this point I don't see a strong reason to change the current
behavior users can depend on...

I've added a comment to udf_parse_options() to explain the code flow.

								Honza

> ---
>  fs/udf/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index ffd8038ff728..1a38271de6d9 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -573,6 +573,8 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
>  				if (uopt->nls_map)
>  					unload_nls(uopt->nls_map);
>  				uopt->nls_map = load_nls(args[0].from);
> +				if (!uopt->nls_map)
> +					return 0;
>  				uopt->flags |= (1 << UDF_FLAG_NLS_MAP);
>  			}
>  			break;
> -- 
> 2.17.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
