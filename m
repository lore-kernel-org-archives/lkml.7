Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCB1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A512173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfC2Hvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:51:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34875 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbfC2Hvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:51:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id a71so834935qkg.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 00:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLSoQu3y/QnClYDyQd7P4FIPsDcqNQYH6y3n+FZFwhY=;
        b=rqCH+l/KSxyJdnuARrSgxg1FBFl9Hm71RTsVgkyqpmN9fmhCCL6hHg3r6tTSRSS/eK
         vPL4D8S2/yegOAVB4F0UxqGf40ivclVGuUtHuDdf+uWiSmcMs/Cgh6dlnscaX//wYhlB
         ygo6w3nZvqPid8nIL4CIzLyJkRsU96fkaIjSG7v+EX/DbheeAQ+PsGGwLyXIpYNYP4Zh
         zYBw0jHYTI8f1GEdM3pTM34jOHf92dIhPqdHIfEj27Tm14TUlIYTjJGMsbEPqP4sI5m+
         gUX+HfvMqRLa5jqawugrfcp+wLmwgI3x6n5w1AhevpdDlDh89H7SXXlCOV4Go0WHzy+6
         aCEw==
X-Gm-Message-State: APjAAAX+im1TPiwUC6vVmGI5P4j/fHu/jvaS0NPILkPyqqddX2jb+lwk
        FpxDqZL66/ceitkpGuuMP8hjHFx4uHQjYoCiQJxHXw==
X-Google-Smtp-Source: APXvYqycBAVlUd2MCkQ48Bu3LKZgqztkBFf9hZGJF9yy7Z9kuVlVYZcdCzQqYjkpYGG1s6Ep0BXgevGVPClqqY5ssiU=
X-Received: by 2002:a05:620a:1244:: with SMTP id a4mr4974673qkl.282.1553845909189;
 Fri, 29 Mar 2019 00:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190327101848.25477-1-nsaenzjulienne@suse.de>
 <BYAPR02MB5607E9396127F67A9A2BEC948A590@BYAPR02MB5607.namprd02.prod.outlook.com>
 <CAO-hwJLatVKwgevfdFk1Lqqpg3H7Oc28_VEkiyxPXne3fhSrqw@mail.gmail.com> <BYAPR02MB560797BC61D1AE47761139B48A5A0@BYAPR02MB5607.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB560797BC61D1AE47761139B48A5A0@BYAPR02MB5607.namprd02.prod.outlook.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 29 Mar 2019 08:51:37 +0100
Message-ID: <CAO-hwJJ926=ivk0avup_H3nAOYCbjkWT1M12wjyizJA2uojqtQ@mail.gmail.com>
Subject: Re: [PATCH v4] HID: core: move Usage Page concatenation to Main item
To:     "Junge, Terry" <terry.junge@poly.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        "oneukum@suse.de" <oneukum@suse.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 1:48 AM Junge, Terry <terry.junge@poly.com> wrote:
>
> On Thursday, March 28, 2019 6:49 AM Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> >>
> >> Hi Nicolas,
> >>
> >> V4 looks good to me.
> >
> >Looks good to me too.
> >
> >Terry, can I consider this as a formal Rev-by you?
>
> Benjamin,
>
> Yes, thank you. What is the normal way of formally indicating Rev-by?
>

Thanks.

So giving a rev-by is described in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst
section 13.

Basically, you just answer a patch with: "Reviewed-by: Your Name
<your@address.sth>" (without quotes).

This has 2 benefits: it's formal, and everybody understands it, and
patchwork (at https://patchwork.kernel.org/patch/10873179/ for this
patch) will catch it. Then with the patchwork client, I can apply the
patch without having to manually add your tag :) (no need to resend
one here, unless you want to  give a try, I'll apply it manually).

Cheers,
Benjamin
