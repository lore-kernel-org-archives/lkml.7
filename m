Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69772C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3360A2087F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AgY5AF+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfEBVZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:25:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35345 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfEBVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:25:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so3539706edr.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqcKatM0uGeQ3Db2t4iHmyuMiU+/ILY+eE3Km3ykIKY=;
        b=AgY5AF+e2le1uHZ3YDirUDNp1TICE3KTNFAqpOvtdLkS6yP1eLKWPoHzGo8y9rmtXP
         W5zYcv98aBbZRyN6WhuuD5cQ5xqFsd7QAANcsN+hKVdl2kYcFm3t/jFqXFnaBJcd2GsR
         XSH+++y4C9Te7uKfEGbSKMFWD0QzFyal9FhNZU8FNJcQpwO1Sh0atef843W+/TVcR2ur
         Xk+F4nnTDSgAxLXtTCOJZ5/rYr63SJP5+lF0QpnikjbrXj+LKIy42y1uDsDvKIN248Ih
         lEBjsaxOweTFgodUin00Y7YTcqWXk0wvSLTestHkzf9wEtJJoQGFzv9jnuBtRgOEJwFy
         o2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqcKatM0uGeQ3Db2t4iHmyuMiU+/ILY+eE3Km3ykIKY=;
        b=fXrU9Whyu76zHSDlqY3W9NmwpQLn4ufHksOtJMk2xxUSzKDRO6U1jsDiCzTsWhgtlv
         ZXRTcU+k6vwJN4kO0ACNu4fpwgJN6MuOuPq6rD0cnLL4ee9MKjCNKtLjK/Qb8CeafbOy
         kyagimLQAM6cYrcG4lfV4hPhBtuqpog9Ng34kEzvjMqzkc83lNX9hkYBJN01AQhOcItB
         JeGKSRqZFKAfT0lfWs2E1ti5O7co31fIUz5nUXXd3g4ZkPUN5Kmdn8IS2lM/I+Nwy+Ll
         ROM3Yy8x9xVKH6WDv43g4NGx0mxb1nnSTDGLAH6IneJQUEDWteFSo0YMfVLFutseK3UB
         1sQA==
X-Gm-Message-State: APjAAAVUqt++0ME7c5NnKnsngvdAqYTVB0SPIkTWeXnyGhydGK/i+Ook
        yLtAFyVGD64NKFl9+0TKtyePYVZuoMQnnCj820/ZBQ==
X-Google-Smtp-Source: APXvYqw1VQMw7Xf/epk8qLnpcgvdR+kuprbmNMpiiIscKSKCrluznkQGvwnw3n2TtUh1xmbwidclePAglNL4CTqh4Pg=
X-Received: by 2002:a50:fb19:: with SMTP id d25mr4206716edq.61.1556832340698;
 Thu, 02 May 2019 14:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552637717.2015392.6818206043460116960.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552637717.2015392.6818206043460116960.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 May 2019 17:25:29 -0400
Message-ID: <CA+CK2bBY2KgLGsXJDhsZe3QV-871O07Yx+fvMwU2_zNNn+zjzA@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] mm/sparsemem: Prepare for sub-section ranges
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 2:53 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Prepare the memory hot-{add,remove} paths for handling sub-section
> ranges by plumbing the starting page frame and number of pages being
> handled through arch_{add,remove}_memory() to
> sparse_{add,remove}_one_section().
>
> This is simply plumbing, small cleanups, and some identifier renames. No
> intended functional changes.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
