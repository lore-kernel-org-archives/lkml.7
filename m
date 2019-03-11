Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9640CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E0B20857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PrOLTmBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfCKMbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:31:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfCKMbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QsSpmeL1Hebpss+Jx+6ZW6eF36y7Do9dQfeCjpXu2tI=; b=PrOLTmBEAevTLPW6LjdHDF9fW
        /aS2Wh60tz4Bry20qwFbeDomF9MBnKa1RhIap2JYIwNm7UETZJQ91KECbRlVOAVFxjfAe2yQDrgG1
        ktErv/+H5bj5ZjNZoZoP94BOP7NcwW+LbOCAOrtC+mST1DmGFNX9fzpoP7X+N16ue8CbuYrh93Gpq
        fd5nbr8MuoOlrl8HxRQBRfGO6/HHmRprtM4oDzHoSdG3ze+D9fNKlzLTQ53XbN2fP/0fA/m74AlGr
        7A+IgZ5/C8TV5kh40MP7kIuvXcL3gYVSn8kg5I3dDBfx5GWCI4L5Ce8yvB53CmcgOoxLl010Mf8k4
        cylcfpQQA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3K5B-0006Fi-V6; Mon, 11 Mar 2019 12:31:05 +0000
Date:   Mon, 11 Mar 2019 05:31:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Message-ID: <20190311123105.GC19508@bombadil.infradead.org>
References: <20190221171332.262cf619@canb.auug.org.au>
 <20190221123440.GD17501@mtr-leonro.mtl.com>
 <20190311024434.GA19508@bombadil.infradead.org>
 <20190311121348.GD22862@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311121348.GD22862@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:13:54PM +0000, Jason Gunthorpe wrote:
> > @@ -1059,14 +1050,14 @@ static int assign_client_id(struct ib_client *client)
> >  	 * to get the LIFO order. The extra linked list can go away if xarray
> >  	 * learns to reverse iterate.
> >  	 */
> > -	if (list_empty(&client_list))
> > +	if (list_empty(&client_list)) {
> >  		client->client_id = 0;
> > -	else
> > -		client->client_id =
> > -			list_last_entry(&client_list, struct ib_client, list)
> > -				->client_id;
> > -	ret = xa_alloc(&clients, &client->client_id, INT_MAX, client,
> > -		       GFP_KERNEL);
> > +	} else {
> > +		struct ib_client *last = list_last_entry(&client_list,
> > +				struct ib_client, list);
> > +		client->client_id = last->client_id + 1;
> 
> blank line after locals, but other wise these all looks fine.. 

Would you rather see this rendered as:

        if (list_empty(&client_list)) {
                client->client_id = 0;
        } else {
                struct ib_client *last; 

                last = list_last_entry(&client_list, struct ib_client, list);
                client->client_id = last->client_id + 1;
        }

or move the declaration of 'last' up to the top of the function?

> Should have started out with the xa_insert version above..

I didn't spot it until last night either ...
