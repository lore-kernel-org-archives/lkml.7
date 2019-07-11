Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5A3C74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B0B214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J6mQidU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfGKDI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 23:08:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfGKDI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 23:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kCf95klSl4II9ASRgUO/dZ/BhEcTH5foAFI3YRAMrm8=; b=J6mQidU9Nu9jXP6cFQwFeAnGJ
        xO6UGwej3f3LcKNTSHthSc5l6QnV9t/41sADhbPOtxwGJhusuqcizgdLeP6A0kw3iBBfdHJRpSfmH
        HrFk1NE5ZhA60nEQ0f9kRYvHq9qW4BMY+rJnC41EK3bl1XcDYqvjRceaeLT967PsfjjZyFP2zaJz6
        JsAXd3+NxpWOEegHY72GEy27CsmwX4tUoVZUaBek+uXF7HqnCAJ/0iblm1DktLNdt2bQUMAAZXlWZ
        wXzYdRlP5JKjh9XlOpX3EA+YNRBDQAp0jhOLmGIXk/bqCHYDMwnqNSrVanzspV5s9nVHue31DN4lb
        MtQRKZtSA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hlPS3-0000Cr-Jj; Thu, 11 Jul 2019 03:08:55 +0000
Date:   Wed, 10 Jul 2019 20:08:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Boaz Harrosh <openosd@gmail.com>,
        stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
Message-ID: <20190711030855.GO32320@bombadil.infradead.org>
References: <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
 <20190703195302.GJ1729@bombadil.infradead.org>
 <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
 <20190704165450.GH31037@quack2.suse.cz>
 <20190704191407.GM1729@bombadil.infradead.org>
 <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
 <20190705191004.GC32320@bombadil.infradead.org>
 <CAPcyv4jVARa38Qc4NjQ04wJ4ZKJ6On9BbJgoL95wQqU-p-Xp_w@mail.gmail.com>
 <20190710190204.GB14701@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710190204.GB14701@quack2.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 09:02:04PM +0200, Jan Kara wrote:
> @@ -848,7 +853,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
>  	if (unlikely(dax_is_locked(entry))) {
>  		void *old_entry = entry;
>  
> -		entry = get_unlocked_entry(xas);
> +		entry = get_unlocked_entry(xas, 0);
>  
>  		/* Entry got punched out / reallocated? */
>  		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))

I'm not sure about this one.  Are we sure there will never be a dirty
PMD entry?  Even if we can't create one today, it feels like a bit of
a landmine to leave for someone who creates one in the future.

