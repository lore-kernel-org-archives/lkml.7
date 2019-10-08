Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A32BC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E001206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k2VwK7Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfJHL7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:59:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46054 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfJHL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:59:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98BxFBu106757;
        Tue, 8 Oct 2019 11:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=OGOkAlNA6LggrLMDrHaCp6Y9p8n1TBUDmTBrqzZFoKM=;
 b=k2VwK7WqwLKkuGuaRfBfCvZQeMRUdCvQU97XC2c3kZ3B3Ba2X0NLSnlTk0p/OXCt6B/t
 h8YN8s8oZ15p7KwDb3ad2OR1q0Q8HRvgCRgKcoSU92zBCqUGic9I9dTDjEUzaXucgUQp
 V5lU4KfX9svKnb78g7ZS30XfPboP3FI8Tbe6c0QsXnFtLvxGJe7GAolIoih+QHagYiZ0
 B8gR9gNHRyq4WFGBCjr1Ji0EC8CMBshjxOjIYbxXNDPUtEJCzwOCsRrsoSHYgYlm0fWX
 SZ4hw8fFCgxk9s2kBSeH8mjBIri34256M1YAC19F8Zh9grHG4mS4cPSkiUxNo+y4tXIm jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vek4qcs64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 11:59:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98BwEXI022092;
        Tue, 8 Oct 2019 11:59:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vg20652rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 11:59:35 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x98BxYQe002725;
        Tue, 8 Oct 2019 11:59:34 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 04:59:34 -0700
Date:   Tue, 8 Oct 2019 14:59:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] staging: wfx: simplify memory allocation in
 wfx_update_filtering()
Message-ID: <20191008115927.GE25098@kadam>
References: <20191008094232.10014-1-Jerome.Pouiller@silabs.com>
 <20191008094232.10014-2-Jerome.Pouiller@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008094232.10014-2-Jerome.Pouiller@silabs.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are good.  I just have a few nits to point out for future
reference.

On Tue, Oct 08, 2019 at 09:42:58AM +0000, Jerome Pouiller wrote:
>  static inline int hif_set_beacon_filter_table(struct wfx_vif *wvif,
> -					      struct hif_mib_bcn_filter_table *ft)
> +					      int tbl_len,
> +					      struct hif_ie_table_entry *tbl)
>  {
> -	size_t buf_len = struct_size(ft, ie_table, ft->num_of_info_elmts);
> +	int ret;
> +	struct hif_mib_bcn_filter_table *val;
> +	int buf_len = struct_size(val, ie_table, tbl_len);

This is fine for now, but since this is networking code, in the future
could you write your declarations in reverse Christmas tree order?

	long laskdfjasldfj asldfkj aslkdfj alskdfj askldfj;
	mid asdfasdflkajdflasjdf lkasjdf;
	short asdfasd;
	shortest i;

>  
> -	cpu_to_le32s(&ft->num_of_info_elmts);
> -	return hif_write_mib(wvif->wdev, wvif->id,
> -			     HIF_MIB_ID_BEACON_FILTER_TABLE, ft, buf_len);

[ snip ]

> diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
> index 2855d14a709c..12198b8f3685 100644
> --- a/drivers/staging/wfx/sta.c
> +++ b/drivers/staging/wfx/sta.c
> @@ -217,14 +217,13 @@ void wfx_update_filtering(struct wfx_vif *wvif)
>  	bool filter_bssid = wvif->filter_bssid;
>  	bool fwd_probe_req = wvif->fwd_probe_req;
>  	struct hif_mib_bcn_filter_enable bf_ctrl;
> -	struct hif_mib_bcn_filter_table *bf_tbl;
> -	struct hif_ie_table_entry ie_tbl[] = {
> +	struct hif_ie_table_entry filter_ies[] = {
>  		{
>  			.ie_id        = WLAN_EID_VENDOR_SPECIFIC,
>  			.has_changed  = 1,
>  			.no_longer    = 1,
>  			.has_appeared = 1,
> -			.oui         = { 0x50, 0x6F, 0x9A},
> +			.oui          = { 0x50, 0x6F, 0x9A },

Please don't do unrelated white space changes in their own patches.

>  		}, {
>  			.ie_id        = WLAN_EID_HT_OPERATION,
>  			.has_changed  = 1,

regards,
dan carpenter

