Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551CBC28D1E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2838120657
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sPdb6bVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfFFKbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:31:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34168 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFFKbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:31:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56AOfEE090289;
        Thu, 6 Jun 2019 10:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=chC2ESL5ETHD38DyfimbY9RtBdco74fFfMWbdfWI37s=;
 b=sPdb6bVX9Qok6LhENtfhx82iUfg9TJljlGnbqE8wGy5gxt8GL3y4zis/zphkxNW7ytSS
 0z2P5b8rPGUO9RKFph0zdIQnjCXHnzJiqEfOrykw5BfTtZ7Im1n8/I1cJjiWak4KfFtI
 NTM9sGIjh7nOC9SC8gMTVzrNQ2nYW7vdxO0JqrX6ZA2VB8WgAxfghcSYAOw4BXlaScVG
 uQQ8gwS+XcUqunslovdAIwhut5tAYIuzFS9g9iOcIz/UX0+xX1VHS9nGvIS1mJIbXYPf
 QNKshbVFTnwlufNr3Fh5Bxm9RPCSva2zs+7dXYwnQF/XtXepcFf/X9/FBPMq850Ic2fc eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sugstqkkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 10:31:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56AV4M4026798;
        Thu, 6 Jun 2019 10:31:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2swngmedha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 10:31:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x56AV5up032634;
        Thu, 6 Jun 2019 10:31:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 03:31:05 -0700
Date:   Thu, 6 Jun 2019 13:30:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        "Koo, Anthony" <Anthony.Koo@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] drm/amd/display: remove redundant assignment to
 status
Message-ID: <20190606103055.GJ31203@kadam>
References: <20190530161219.2507-1-colin.king@canonical.com>
 <a190bcd5-cda8-84c6-093a-98438a605032@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a190bcd5-cda8-84c6-093a-98438a605032@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 08:19:03PM +0000, Harry Wentland wrote:
> On 2019-05-30 12:12 p.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The variable status is initialized with a value that is never read
> > and status is reassigned several statements later. This initialization
> > is redundant and can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index 65d6caedbd82..cf6166a1be53 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -2367,7 +2367,7 @@ static bool retrieve_link_cap(struct dc_link *link)
> >  	union down_stream_port_count down_strm_port_count;
> >  	union edp_configuration_cap edp_config_cap;
> >  	union dp_downstream_port_present ds_port = { 0 };
> > -	enum dc_status status = DC_ERROR_UNEXPECTED;
> > +	enum dc_status status;
> 
> Not sure this improves the situation.
> 
> I'd prefer to have a default here in case someone changes the code below
> and forgets to set the status.

The dead code confuses human readers, because people naturally assume it
is not dead.

GCC has a feature to warn about uninitialized variables and we're
randomly initializing status to a bogus value to disable static
analysis...

regards,
dan carpenter

