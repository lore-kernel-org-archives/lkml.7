Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEFBC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07782053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o+//pkDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfEFPVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:21:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57828 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEFPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:21:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46FJUE9100526;
        Mon, 6 May 2019 15:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=EMVZPLqed0spBkywKOWEg6NbdmaW+XOPtfLd8HpUuQA=;
 b=o+//pkDQTwrEiN/m7EtTacjF2kEO4BVGJ863xaNH+7J97F7Q005ch5iCjuEBzkSVpTVs
 1o4SQYO/i591KoUMPrShWoengb/1w9HObMGuowgIZp9I2MWLRwFwaizoxaR7PnMpj2wc
 /30HeJBHaBZ6unYXinEL1fj03mHtUiJW5YAozN7NrV3x+6JO5oGc6eZBxzBjEG7SQ0lf
 eVAobDru/jZMNGlGeAyDs2bPRxY7maYxTkckQbC0FthV1n2VJoACoATVCydYFrlkrwGf
 QTR/SArMQxNOXRus8ZE0fVlekFK+rd3vu7o0ttzXZeR2Unc8d97ymTc1S4XjDvUBIhTJ UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2s94bfq9xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 15:20:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46FJpM2086866;
        Mon, 6 May 2019 15:20:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2sagytdvgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 15:20:56 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x46FKrgf007496;
        Mon, 6 May 2019 15:20:53 GMT
Received: from kadam (/196.110.137.40)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 May 2019 08:20:52 -0700
Date:   Mon, 6 May 2019 18:20:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org, phil@raspberrypi.org,
        stefan.wahren@i2se.com, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 2/3] staging: vchiq: revert "switch to
 wait_for_completion_killable"
Message-ID: <20190506152039.GT2239@kadam>
References: <20190506144030.29056-1-nsaenzjulienne@suse.de>
 <20190506144030.29056-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506144030.29056-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905060131
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905060131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:40:29PM +0200, Nicolas Saenz Julienne wrote:
> @@ -1740,7 +1740,8 @@ parse_rx_slots(struct vchiq_state *state)
>  					&service->bulk_rx : &service->bulk_tx;
>  
>  				DEBUG_TRACE(PARSE_LINE);
> -				if (mutex_lock_killable(&service->bulk_mutex)) {
> +				if (mutex_lock_killable(
> +					&service->bulk_mutex) != 0) {

This series does't add != 0 consistently...  Personally, I would prefer
we just leave it out.  I use != 0 for two things.  1)  When I'm talking
about the number zero.

	if (len == 0) {

Or with strcmp():

	if (strcmp(a, b) == 0) { // a equals b
	if (strcmp(a, b) < 0) {  // a less than b.

But here zero means no errors, so I would just leave it out...

regards,
dan carpenter

