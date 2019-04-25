Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1DAC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA8820717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfDYUQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:16:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfDYUQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:16:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7846C8E581;
        Thu, 25 Apr 2019 20:16:27 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE9895D9CC;
        Thu, 25 Apr 2019 20:16:25 +0000 (UTC)
Date:   Thu, 25 Apr 2019 16:16:24 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] NUMA, memory hierarchy and device memory
Message-ID: <20190425201623.GB6391@redhat.com>
References: <20190118174512.GA3060@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190118174512.GA3060@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 25 Apr 2019 20:16:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I see that the schedule is not full yet for the mm track and i would
really like to be able to have a discussion on this topic

Schedule:
https://docs.google.com/spreadsheets/d/1Z1pDL-XeUT1ZwMWrBL8T8q3vtSqZpLPgF3Bzu_jejfk/edit#gid=0


On Fri, Jan 18, 2019 at 12:45:13PM -0500, Jerome Glisse wrote:
> Hi, i would like to discuss about NUMA API and its short comings when
> it comes to memory hierarchy (from fast HBM, to slower persistent
> memory through regular memory) and also device memory (which can have
> its own hierarchy).
> 
> I have proposed a patch to add a new memory topology model to the
> kernel for application to be able to get that informations, it
> also included a set of new API to bind/migrate process range [1].
> Note that this model also support device memory.
> 
> So far device memory support is achieve through device specific ioctl
> and this forbid some scenario like device memory interleaving accross
> multiple devices for a range. It also make the whole userspace more
> complex as program have to mix and match multiple device specific API
> on top of NUMA API.
> 
> While memory hierarchy can be more or less expose through the existing
> NUMA API by creating node for non-regular memory [2], i do not see this
> as a satisfying solution. Moreover such scheme does not work for device
> memory that might not even be accessible by CPUs.
> 
> 
> Hence i would like to discuss few points:
>     - What proof people wants to see this as problem we need to solve ?
>     - How to build concensus to move forward on this ?
>     - What kind of syscall API people would like to see ?
> 
> People to discuss this topic:
>     Dan Williams <dan.j.williams@intel.com>
>     Dave Hansen <dave.hansen@intel.com>
>     Felix Kuehling <Felix.Kuehling@amd.com>
>     John Hubbard <jhubbard@nvidia.com>
>     Jonathan Cameron <jonathan.cameron@huawei.com>
>     Keith Busch <keith.busch@intel.com>
>     Mel Gorman <mgorman@techsingularity.net>
>     Michal Hocko <mhocko@kernel.org>
>     Paul Blinzer <Paul.Blinzer@amd.com>
> 
> Probably others, sorry if i miss anyone from previous discussions.
> 
> Cheers,
> Jérôme
> 
> [1] https://lkml.org/lkml/2018/12/3/1072
> [2] https://lkml.org/lkml/2018/12/10/1112
> 
