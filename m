Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4966C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF5B20867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfJHB7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:59:32 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:43190 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbfJHB7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:59:32 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x981ukGB014081;
        Tue, 8 Oct 2019 01:59:21 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 2vg3pwm8p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 01:59:21 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id E1E7763;
        Tue,  8 Oct 2019 01:59:20 +0000 (UTC)
Received: from hpe.com (teo-eag.americas.hpqcorp.net [10.33.152.10])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 4A4EC36;
        Tue,  8 Oct 2019 01:59:20 +0000 (UTC)
Date:   Mon, 7 Oct 2019 20:59:20 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Joe Perches <joe@perches.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] sgi-gru: simplify procfs code some more
Message-ID: <20191008015919.GA10893@hpe.com>
References: <cce61906a5f7f42f5b2b8b947fc61357bcb56e71.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce61906a5f7f42f5b2b8b947fc61357bcb56e71.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_05:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=9
 adultscore=0 mlxlogscore=985 impostorscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910080019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While a reduction in object size is welcome, in this case it does come at the
expense of some clarity, as field sizes are no longer as clear.
Nevertheless, will add my ack.

Acked-by: Dimitri Sivanich <sivanich@hpe.com>

On Mon, Oct 07, 2019 at 11:30:46AM -0700, Joe Perches wrote:
> Use seq_puts and simple string output and not seq_printf with formats
> and individual strings to reduce overall object size.
> 
> $ size drivers/misc/sgi-gru/gruprocfs.o* (x86-64 defconfig with gru)
>    text	   data	    bss	    dec	    hex	filename
>    7006	      8	      0	   7014	   1b66	drivers/misc/sgi-gru/gruprocfs.o.new
>    7472	      8	      0	   7480	   1d38	drivers/misc/sgi-gru/gruprocfs.o.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/misc/sgi-gru/gruprocfs.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/gruprocfs.c b/drivers/misc/sgi-gru/gruprocfs.c
> index 3a8d76d1ccae..2817f4751306 100644
> --- a/drivers/misc/sgi-gru/gruprocfs.c
> +++ b/drivers/misc/sgi-gru/gruprocfs.c
> @@ -119,7 +119,7 @@ static int mcs_statistics_show(struct seq_file *s, void *p)
>  		"cch_interrupt_sync", "cch_deallocate", "tfh_write_only",
>  		"tfh_write_restart", "tgh_invalidate"};
>  
> -	seq_printf(s, "%-20s%12s%12s%12s\n", "#id", "count", "aver-clks", "max-clks");
> +	seq_puts(s, "#id                        count   aver-clks    max-clks\n");
>  	for (op = 0; op < mcsop_last; op++) {
>  		count = atomic_long_read(&mcs_op_statistics[op].count);
>  		total = atomic_long_read(&mcs_op_statistics[op].total);
> @@ -165,8 +165,7 @@ static int cch_seq_show(struct seq_file *file, void *data)
>  	const char *mode[] = { "??", "UPM", "INTR", "OS_POLL" };
>  
>  	if (gid == 0)
> -		seq_printf(file, "#%5s%5s%6s%7s%9s%6s%8s%8s\n", "gid", "bid",
> -			   "ctx#", "asid", "pid", "cbrs", "dsbytes", "mode");
> +		seq_puts(file, "#  gid  bid  ctx#   asid      pid  cbrs dsbytes    mode\n");
>  	if (gru)
>  		for (i = 0; i < GRU_NUM_CCH; i++) {
>  			ts = gru->gs_gts[i];
> @@ -191,10 +190,8 @@ static int gru_seq_show(struct seq_file *file, void *data)
>  	struct gru_state *gru = GID_TO_GRU(gid);
>  
>  	if (gid == 0) {
> -		seq_printf(file, "#%5s%5s%7s%6s%6s%8s%6s%6s\n", "gid", "nid",
> -			   "ctx", "cbr", "dsr", "ctx", "cbr", "dsr");
> -		seq_printf(file, "#%5s%5s%7s%6s%6s%8s%6s%6s\n", "", "", "busy",
> -			   "busy", "busy", "free", "free", "free");
> +		seq_puts(file, "#  gid  nid    ctx   cbr   dsr     ctx   cbr   dsr\n");
> +		seq_puts(file, "#             busy  busy  busy    free  free  free\n");
>  	}
>  	if (gru) {
>  		ctxfree = GRU_NUM_CCH - gru->gs_active_contexts;
> 
> 
