Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04354CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDD9222C1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZkSFcjBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfKDLEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:04:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33212 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfKDLEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:04:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4Aspen009835;
        Mon, 4 Nov 2019 11:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=oh9GH8wwoClSgQg02TQwxOW2wUym3I4ltRRW2QDdUmI=;
 b=ZkSFcjBepb5Cn8ydb20IE6DxCgFEHeYhfzbFj/jMRNHUcFgYEUF73K+u9IG1Z72TOpom
 gy+jXwfwhuMpJPZMZQe0lKHzHVobAHu9SwQXXqH9URNO/lfE2Es+ANEhZx6MOYUf6aKn
 McjbcHPdnLiBEIixhSGg2MkM9yOfoBsf39C02zisi8bfD/9gwDiNq0YLzqGGYY3KTXQK
 tznzvi1TxfRU+kiNETpRIBbKnijsgFm+PUfn/mcfNC+/U46xnCd4wn4fJEmfvqYS9gQl
 4CC4u5Klhd5JhKh3W8IjPZ8Z3kzjGSP+n/bEj6+g3aKBgI66G6dvgtwgu+LClLuoDN3w tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w11rppg8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 11:04:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4Asstb142626;
        Mon, 4 Nov 2019 11:04:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2w1kxd2503-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 11:04:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA4B3xwR006069;
        Mon, 4 Nov 2019 11:03:59 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 03:03:58 -0800
Date:   Mon, 4 Nov 2019 14:03:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] staging: wfx: Fix a memory leak in 'wfx_upload_beacon'
Message-ID: <20191104110352.GD10409@kadam>
References: <20191102155945.20205-1-christophe.jaillet@wanadoo.fr>
 <4126113.6ZGdBP45BV@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4126113.6ZGdBP45BV@pc-42>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:42:43AM +0000, Jerome Pouiller wrote:
> On Saturday 2 November 2019 16:59:45 CET Christophe JAILLET wrote:
> > The current code is a no-op, because all it can do is 'dev_kfree_skb(NULL)'
> > Remove the test before 'dev_kfree_skb()'
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > V2: remove the 'if(...)', 'dev_kfree_skb()' can handle NULL.
> > ---
> >  drivers/staging/wfx/sta.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
> > index 688586e823c0..93f3739b5f3a 100644
> > --- a/drivers/staging/wfx/sta.c
> > +++ b/drivers/staging/wfx/sta.c
> > @@ -906,8 +906,7 @@ static int wfx_upload_beacon(struct wfx_vif *wvif)
> >         wfx_fwd_probe_req(wvif, false);
> > 
> >  done:
> > -       if (!skb)
> > -               dev_kfree_skb(skb);
> > +       dev_kfree_skb(skb);
> >         return ret;
> >  }
> > 
> > --
> > 2.20.1
> > 
> 
> In add, value of skb is tested earlier in function. So, it is guaranteed to be 
> never NULL.

See the start of the function:

   868  static int wfx_upload_beacon(struct wfx_vif *wvif)
   869  {
   870          int ret = 0;
   871          struct sk_buff *skb = NULL;
   872          struct ieee80211_mgmt *mgmt;
   873          struct hif_mib_template_frame *p;
   874  
   875          if (wvif->vif->type == NL80211_IFTYPE_STATION ||
   876              wvif->vif->type == NL80211_IFTYPE_MONITOR ||
   877              wvif->vif->type == NL80211_IFTYPE_UNSPECIFIED)
   878                  goto done;
                        ^^^^^^^^^
This why I argue that goto done is monkey poop.  You see this and you
wonder "what on earth does goto done do?"  We haven't allocated anything
so what are we going to free?  The name doesn't give any hints at all.
So you have to scroll down.  Now you have lost your place and cleared
out your short term memory about the code that you were reading.  But
then you get to goto done and you see it is a complicated no op, and it
return ret.  So you have to scroll back up to the very start of the
function to see what ret is.

And the you wonder, is this really a success path?  It could be
deliberate or it could be accidental.  Who knows!  The "goto done;" is
ambiguous and take a long time to understand but "return 0;" is
instantly clear.

   879  
   880          skb = ieee80211_beacon_get(wvif->wdev->hw, wvif->vif);
   881  
   882          if (!skb)
   883                  return -ENOMEM;
   884  
   885          p = (struct hif_mib_template_frame *) skb_push(skb, 4);

regards,
dan carpenter

