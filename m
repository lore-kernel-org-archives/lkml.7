Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE9AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A54720684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cm5cI6YW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfCFBv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:51:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42842 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCFBv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:51:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id y140so5928068qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 17:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v6MB5vJdZeiiHNLIrZXL/NLvLcz3ucN8qXhApNV7Iiw=;
        b=cm5cI6YWkf7V25AX5Q095XofnBZM83Z799SR5Hj0xpHNemxsMbBYK1igTraRwwZiS0
         TKYkfSF9DxdrFVctI+T17j6+ch0QnRioMl/BB5aLn0BYxSd3fclhE1PzwI3E05UtwAgs
         bPrLwcZyF9WXp+Dmbc11iEHJUjs8UGi4B84prphbaglRGQyQkmeqU4jOtFOywmtsR/2F
         bGafNzjRVvb7Po3uLZssuOLwrOgI4siaIZO13QA6mk+7wiAqrOmQZVc2W7bD2mGlIr+U
         2T0CayC8nf1s2D+3e1SWLrgwrC55xcuciVWqghj2zIOp37dbida4iH7HIqpDOkc67vhs
         GnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v6MB5vJdZeiiHNLIrZXL/NLvLcz3ucN8qXhApNV7Iiw=;
        b=Y6G4miLos9QyhsP254dWQwjUMdc2pPN4JUswK9trtyfuh7zqLLkuqbqN5/YIP5DywJ
         uYGkAHkGCT/fL4j/+5a1rCv7GskWGivCc3jeQ1PIO4NRoqYLzKwdAC+MeLpg7QV3gEX6
         rGXWvkL6MC0DEpl0KZ35vKecqFCwBa3lr1NLX3q86ssNYGty8OqKy9nTn0VZ/BMzb89X
         g3TCjsU6PNCqgMDcayLKaciCIRC5k3cClLgzDpsFwYdVApzh78X+QtLbXekUwsZg8nRZ
         Y9gSeL6MGpOM3vm1/G08xhyxL8/RyGOSClAMs0O48L/6HjBpamLYUf18S8gq6GzQbn/5
         zyFw==
X-Gm-Message-State: APjAAAUWiwyE7QfE0/lk/vMPgIORaehw0graBrQ1xCVg7vhaFpb3PkIP
        p3dT7YQuZqbGE/iCGwCEI7xhSg==
X-Google-Smtp-Source: APXvYqznGQheXDfcxLaQ+k6XFcHgn8YhhBKGfvoBKRHdUuorNpm74Waut7EbJuCKvjrwi+QWbKUEnA==
X-Received: by 2002:a37:a42:: with SMTP id 63mr3997954qkk.269.1551837085787;
        Tue, 05 Mar 2019 17:51:25 -0800 (PST)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id z140sm156227qka.81.2019.03.05.17.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 17:51:25 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h1LiN-0002Ag-QC; Tue, 05 Mar 2019 21:51:23 -0400
Date:   Tue, 5 Mar 2019 21:51:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Artemy Kovalyov <artemyko@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "john.hubbard@gmail.com" <john.hubbard@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/umem: minor bug fix and cleanup in error
 handling paths
Message-ID: <20190306015123.GB1662@ziepe.ca>
References: <20190302032726.11769-2-jhubbard@nvidia.com>
 <20190302202435.31889-1-jhubbard@nvidia.com>
 <20190302194402.GA24732@iweiny-DESK2.sc.intel.com>
 <2404c962-8f6d-1f6d-0055-eb82864ca7fc@mellanox.com>
 <332021c5-ab72-d54f-85c8-b2b12b76daed@nvidia.com>
 <903383a6-f2c9-4a69-83c0-9be9c052d4be@mellanox.com>
 <20190306013213.GA1662@ziepe.ca>
 <74f196a1-bd27-2e94-2f9f-0cf657eb0c91@nvidia.com>
 <be6303c6-d8d2-483a-5271-b6707c21178e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be6303c6-d8d2-483a-5271-b6707c21178e@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 05:37:18PM -0800, John Hubbard wrote:
> On 3/5/19 5:34 PM, John Hubbard wrote:
> [snip]
> >>> So release_pages(&local_page_list[j+1], npages - j-1) would be correct.
> >>
> >> Someone send a fixup patch please...
> >>
> >> Jason
> > 
> > Yeah, I'm on it. Just need to double-check that this is the case. But Jason,
> > you're confirming it already, so that helps too.

I didn't look, just assuming Artemy is right since he knows this
code..

> > Patch coming shortly.
> > 
> 
> Jason, btw, do you prefer a patch that fixes the previous one, or a new 
> patch that stands alone? (I'm not sure how this tree is maintained, exactly.)

It has past the point when I should apply a fixup, rdma is general has
about an approximately 1 day period after the 'thanks applied' message
where rebase is possible

Otherwise the tree is strictly no rebase

Jason
