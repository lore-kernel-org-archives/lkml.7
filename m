Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387B4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A4520835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569235019;
	bh=BppCWNTpLIPrS0K8rfJOfwEbWt7gnr6BUWkaLs0Xs6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WDzmO5gZGTwg7CWcEhiOSHzIg//EDPOhDKlXcRymrU1brZHL66Kj9yyaZI4+5XC+6
	 oQxFzJGPu71rlMItGcY4A5BHWsZNZ3GPivbrXYQrsgooZE24GX1Vrci26PuDRo6NAj
	 QQXPnWM3AeGaULmmpFt6mnXA4uzrPKyTS0xDbOKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439399AbfIWKg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:36:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:36674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727056AbfIWKg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:36:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 803F7B018;
        Mon, 23 Sep 2019 10:36:56 +0000 (UTC)
Date:   Mon, 23 Sep 2019 12:36:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/9] ACPI: NUMA: export pxm_to_node
Message-ID: <20190923103655.GG6016@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
 <20190919142228.5483-2-david@redhat.com>
 <f4d8204e-71a1-855e-3992-35f7ec90440c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4d8204e-71a1-855e-3992-35f7ec90440c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-09-19 12:13:11, David Hildenbrand wrote:
> On 19.09.19 16:22, David Hildenbrand wrote:
> > Will be needed by virtio-mem to identify the node from a pxm.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  drivers/acpi/numa.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> > index eadbf90e65d1..d5847fa7ac69 100644
> > --- a/drivers/acpi/numa.c
> > +++ b/drivers/acpi/numa.c
> > @@ -35,6 +35,7 @@ int pxm_to_node(int pxm)
> >  		return NUMA_NO_NODE;
> >  	return pxm_to_node_map[pxm];
> >  }
> > +EXPORT_SYMBOL(pxm_to_node);
> 
> FWIW, this is a fairly old patch I dragged along and I think I'll
> convert this to EXPORT_SYMBOL_GPL now that I know better :)

All other exports in this file are EXPORT_SYMBOL. Why is this one
considered special to restrict the access?
-- 
Michal Hocko
SUSE Labs
