Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_HDRS_LCASE,PDS_TONAME_EQ_TOLOCAL_SHORT,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7698EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D81222DD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyjv0+S1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfKRVWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:22:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37690 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRVWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:22:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id bb5so10484716plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aSzFRLe2mDa0I96NWr1Lb6uvkLNDlqVI+nwWNFi/OEk=;
        b=eyjv0+S1cjWe1v6TECX9BBS+aBKSQiJjLuO3CpsTCHblcQJ/4D2wGwYWb+bAGP8sTs
         0ReqYhdSOr6mT5JOn3Iy3NOVROesnesfQa2xk36Tnd79QRNNfb42p4rRqI1FCO+/Brmo
         joTkiFb/CTfaMcBAGYu0wsvXywYIYKFFe3SbGvSyVZXa2k/5df9rRFmfE0fC3rxLl0BA
         Ki/OjjNQwbVoodENxWTblMist3V2jbx6nZofoWjcuHiINB1Qn4yXDmvKfgfMpqPxEnc+
         /l3ZBJs6iKzuC/+4OL9Ilwiz8/g09lHipIBFtRDh8im7KN4JIPK2PmOLOZECjpyyso34
         jyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aSzFRLe2mDa0I96NWr1Lb6uvkLNDlqVI+nwWNFi/OEk=;
        b=PNk0rbTgL3sSR1QzosG0dfZbkRuRjJ1bxbKABOBB6vl55oRF+Dfyi7wSINBTroJVMq
         I0iMIOfnhesXkLsqI4UboqQ1gwfrrFKxqKEpwfBSQwMneX+9gYWmYCS4o5OQwBaRDDDa
         72/vEGhUsNk7IifPrbdkdm3OgVMWWFgN8wWN3MceDLEGF3qdTslmnlccusiQJ3wXe9JL
         2nSsLGWlAiKUwOdXN1DZBpuy8K7qaR5TIUxZqUDZBK0Dr/R0JteJoTec8eywmhFLdLp3
         GJepf/ULGzbfMdDOsp3qhyTJ6PlVrRzUyzFyLtM3Dcq1C24UiDsMlZFLSMX5tPNE8s8F
         roWQ==
X-Gm-Message-State: APjAAAUt+Crk33FposvzxzBtF3Es8MB11j/XK4mMWO/WLqLsG4HQYxRQ
        4aDLVh1oeXJuBXXKPygVqe0fzw==
X-Google-Smtp-Source: APXvYqymUoerdhYLn0Q+giAK++AaRTfGyW+rKfYQM0polVwI6u08y0l3FMzgDkwlKyLq/t0ajER5ew==
X-Received: by 2002:a17:90a:25a1:: with SMTP id k30mr1487308pje.9.1574112159125;
        Mon, 18 Nov 2019 13:22:39 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x25sm20832290pfq.73.2019.11.18.13.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:22:38 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:22:37 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     linmiaohe <linmiaohe@huawei.com>
cc:     akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        sfr@canb.auug.org.au, rppt@linux.ibm.com, jannh@google.com,
        steve.capper@arm.com, catalin.marinas@arm.com, aarcange@redhat.com,
        walken@google.com, dave.hansen@linux.intel.com,
        tiny.windzz@gmail.com, jhubbard@nvidia.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
In-Reply-To: <1574079844-17493-1-git-send-email-linmiaohe@huawei.com>
Message-ID: <alpine.DEB.2.21.1911181322250.112090@chino.kir.corp.google.com>
References: <1574079844-17493-1-git-send-email-linmiaohe@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019, linmiaohe wrote:

> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> The jump labels try_prev and none are not really needed
> in find_mergeable_anon_vma(), eliminate them to improve
> readability.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: David Rientjes <rientjes@google.com>
