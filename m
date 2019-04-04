Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D4EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D47A206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfDDN2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:28:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33617 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDN2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:28:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id k14so3214386qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7yyf+HgxleLYBHaKJbIu80u0jEokOC4UH8AehtEvcEM=;
        b=MM0lL9E+r6d+hZgeFBX2WIxyAmlUBqi3r3LSOUw4eURXRTvwIrNwI+bjnml/7wCoYS
         1kguwPZeW1HH+dM4474c3k4Ty/WlTOeQqFb4kxzViOV6qnBI6BBse0pswbZp4Al1+T8z
         PCdwYQmT+yko2zd+SN6IzAPH3OyCO7m5neDsB4O2R7EV1CF/EZclNc59DwdpLvvXiyO5
         Bxe1u2e5AW/cSLJHZzVznWTi/BZHj6kL1jyhdgeCNz02PHABvTPHk3jDWg2okg/m1mdg
         k5PdMUvPDDXRkw5WUjFp+vZm3t6hGLSN0C9sjUb83zAQdhHWVJQToQsHwXqiwuky7whu
         d0hg==
X-Gm-Message-State: APjAAAX0QRG/s6+ndMhR0Uo6/7Tf7U+qLY56WW0tWlGKSSnVqmcn9JO0
        M7XPH6H+DikOqtxz4eN6RwapTw==
X-Google-Smtp-Source: APXvYqyGfRXpzQFNaSliZNlz6/G8SzOU+HMRc8xYFoGZ0ZQbt0QhYGmCO8b8oYZ6Q0w9Htvlju38sw==
X-Received: by 2002:ac8:28e9:: with SMTP id j38mr5244597qtj.297.1554384522144;
        Thu, 04 Apr 2019 06:28:42 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id q51sm12443768qtc.38.2019.04.04.06.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 06:28:41 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:28:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: On guest free page hinting and OOM
Message-ID: <20190404083321-mutt-send-email-mst@kernel.org>
References: <29e11829-c9ac-a21b-b2f1-ed833e4ca449@redhat.com>
 <dc14a711-a306-d00b-c4ce-c308598ee386@redhat.com>
 <20190401104608-mutt-send-email-mst@kernel.org>
 <CAKgT0UcJuD-t+MqeS9geiGE1zsUiYUgZzeRrOJOJbOzn2C-KOw@mail.gmail.com>
 <6a612adf-e9c3-6aff-3285-2e2d02c8b80d@redhat.com>
 <CAKgT0Ue_By3Z0=5ZEvscmYAF2P40Bdyo-AXhH8sZv5VxUGGLvA@mail.gmail.com>
 <1249f9dd-d22d-9e19-ee33-767581a30021@redhat.com>
 <CAKgT0UeqX8Q8BYAo4COfQ2TQGBduzctAf5Ko+0mUmSw-aemOSg@mail.gmail.com>
 <0fdc41fb-b2ba-c6e6-36b9-97ad5a6eb54c@redhat.com>
 <CAKgT0UcrkXKjMgYy2H3MKQxG71ScNqhwqxwti7QjvPSxtb8FBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcrkXKjMgYy2H3MKQxG71ScNqhwqxwti7QjvPSxtb8FBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 04:43:03PM -0700, Alexander Duyck wrote:
> Yes, but hopefully it should be a small enough amount that nobody will
> notice. In many cases devices such as NICs can consume much more than
> this regularly for just their Rx buffers and it is not an issue. There
> has to be a certain amount of overhead that any given device is
> allowed to consume. If we contain the balloon hinting to just 64M that
> should be a small enough amount that nobody would notice in practice.

I am still inclined to add ability for balloon to exit to host on OOM
if any hints are outstanding.

If nothing else will be helpful for stats.

-- 
MST
