Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B618AC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865752168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558103900;
	bh=vHarI6Bq02RsUBTKcslNd5uZEFTIkJp8KiVz4G02BZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tPJaivYxXV1fO1ZsOi85wqbbeWA3vRRN77aUn2bvg4+Mqq92J0niZQWEdB3EXUICN
	 el2oVqroI5FsoFMHT55Dngfa9tXyf2kyPfnIzRtlCBYqxWx6VngGUB9oTkVfyU9C6B
	 +vTx0epXZ9aAioZkp1p1aF2z3XJc93ILO16Yp+/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfEQOiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 10:38:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:59174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727516AbfEQOiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 10:38:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CF3FAC31;
        Fri, 17 May 2019 14:38:17 +0000 (UTC)
Date:   Fri, 17 May 2019 16:38:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>, "bp@suse.de" <bp@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>
Subject: Re: NULL pointer dereference during memory hotremove
Message-ID: <20190517143816.GO6836@dhcp22.suse.cz>
References: <CA+CK2bBeOJPnnyWBgj0CJ7E1z9GVWVg_EJAmDs07BSJDp3PYfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBeOJPnnyWBgj0CJ7E1z9GVWVg_EJAmDs07BSJDp3PYfQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-05-19 10:20:38, Pavel Tatashin wrote:
> This panic is unrelated to circular lock issue that I reported in a
> separate thread, that also happens during memory hotremove.
> 
> xakep ~/x/linux$ git describe
> v5.1-12317-ga6a4b66bd8f4

Does this happen on 5.0 as well?
-- 
Michal Hocko
SUSE Labs
