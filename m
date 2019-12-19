Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4B3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9135D2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvFqvh8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLSB7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:59:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41160 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfLSB7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:59:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so5000828otc.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 17:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQOUWeuTEyIUZEEQ2jTpgmNLbvpJOv+XxTa7wYSNX3g=;
        b=OvFqvh8YdAzV55/KDAESLZTnpZ9T/+xm2NNdL3mtyu1mL1Ber7NA3Ncg6I6b7iipv/
         87+tC1A2QDAE4hEaupil/r5OgnOAU0+LIexdh4XDQlJ5PBsHVM39PSrtZl+WeVzBuZny
         6kGu+jbsvpGz8aZPi8Ne1veypupNUpV2ZlQG9SlklJQRVHIPyapP0sLjfUYrK1yPN9g8
         XAWgXdrzAfdnGfaUrLVhKsvUO0epe+i4E2S+uTxfmEQWjHer1Cua9iTKw82qgNrlfn7X
         ito3480sINFyoXjWIBRX75+wF64wksHkV3bEmsaHR9fp9gjzkFdjPPjPQ3k35CqUyLDa
         ABrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQOUWeuTEyIUZEEQ2jTpgmNLbvpJOv+XxTa7wYSNX3g=;
        b=IdkSkUGtfjqFkH+CpVG8FYyzncktWFA32YcTjj+RduXuNNxQd/w7J/+zJ/8qofbNyK
         sUzzv8ltbRymJpFVmla2pLeWhWUlv5n6YoyfXOYUh3sHPVwVkzFClWzI2GCc5lw2PzG0
         tmYDiZFb++BBIr22RhlX8dGu8YaWcqk6hWlBLUCUJ78A7PlvQ9j6ya6L1hyC8TRxrp4q
         YeCSLC/XqWMfJmmAp0xMxfhBsHqf4r9hYghqMpTKU+NSdUfEP37I+YDmHcukohvEM2b5
         9T/fnfMN43GQ5gvo1tasH4eWhBAQDsLvTXxP55XW7iTGFP00Lh8JaKYEVI/kJ4bLtA5/
         0kpQ==
X-Gm-Message-State: APjAAAUDVNSpxdbUKPiTuH8lUiwvYNaEHHAVtwPm0KQDUuVbj05+Esrr
        1yk+hH0c3L/fcsDXoTMGqzlH7Z2YP2KFMNgbS8jsvA==
X-Google-Smtp-Source: APXvYqz1ha9qc+r4oDyIBgGQt/Isc2y55K20/dwEtbJTlEEWs6r5FLMbK9py0Kzjg45819sYbwm3CtqEmDDBcaTRo3Q=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr6290845ota.127.1576720768716;
 Wed, 18 Dec 2019 17:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
 <20191218171254.79664a964c0c61e6054dff64@linux-foundation.org> <4d11fb25-5036-6c78-5328-10a0c14e8edc@oracle.com>
In-Reply-To: <4d11fb25-5036-6c78-5328-10a0c14e8edc@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 18 Dec 2019 17:59:17 -0800
Message-ID: <CAHS8izMSjyMGTCH-tffiPam_yG9=10v+O617E2cpxWx8SETt3w@mail.gmail.com>
Subject: Re: [PATCH v9 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 5:37 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/18/19 5:12 PM, Andrew Morton wrote:
> > On Tue, 17 Dec 2019 15:16:08 -0800 Mina Almasry <almasrymina@google.com> wrote:
> <snip>
> >> This proposal is implemented in this patch series, with tests to verify
> >> functionality and show the usage. We also added cgroup-v2 support to
> >> hugetlb_cgroup so that the new use cases can be extended to v2.
> >
> > This would make
> > http://lkml.kernel.org/r/20191216193831.540953-1-gscrivan@redhat.com
> > obsolete?
>
> I haven't started looking at this series yet.  However, since Mina was
> involved in the discussion of that patch (hugetlb controller for cgroups v2)
> my assumption is that this patch would simply build on that v2 support?
> Seems like the above patch would be a prereq for this series.
>
> Mina, are those assumptions correct and perhaps this is an old/obsolete
> comment?  Does this series apply 'on top' of the above patch?  That patch
> is already in Andrew's tree.

Gah, I just forgot to update this commit message. This patch series is
indeed on top of Giuseppe's v2 support and doesn't conflict or
duplicate that functionality. Sorry for the confusion. I'll fix the
commit message in the next iteration.

> --
> Mike Kravetz
