Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181B6C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E574E2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRIbyl+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfFSLFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:05:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38422 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731267AbfFSLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:05:24 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so7517608ioa.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCYlhd274MLja1aUjw9jbduFZsTE4iqm0XJqesczC2M=;
        b=uRIbyl+LBSLzrLgEFoRCXr89GPeHdisG96TJxaKDMULVeZsHUdogijixV+ND5zVaqX
         MJVl5pKFkSpIUFYawtVhoagKOYReGf58P5kKHrWQB0sNmS75c+iKdm4YsGisvFLz+gHi
         nOCGvdxlTADF7UIkLMfSOq1pRDe3YHqR1DbU08nx95eTqBsM0Dg4nVtiPpFGWkOZ0O7e
         KC/7kyd5JLcj/Dne4UaPNNjtzozxEhqgDc1TfSVWzrV2TpsRBOmjqu0s+l993ORMyK5R
         ifgZk01ODPnZjlQNqYJdVMFeQEn+P9cbmGapOLUoWemFJ7MAB2ZyRycuZg8/D5tbsSXE
         +WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCYlhd274MLja1aUjw9jbduFZsTE4iqm0XJqesczC2M=;
        b=V156o9C0PC3EXayi4DE9UJ9unaXrg7qxEH/KdZAlV0sH1f8bHclO+WHHcw3B0JxUtP
         FYNb3YJQGXpK2aG0ql0r8n0QJMVdLkKnXkySrMPgqnYnf7Hkft5pKcbc8uDi9klbB08T
         8p5A015BZUHOeBk+SMlJE6DIWH7jZySge7GuLbBqr8hOg4wVe2Q4vYKGwt0A0D694maf
         WLVsmQGC3CCxHS0+17GQZJCjv2H2e4nnCduH4hOb3zZtD8638UNMw0FMrJZrV+1J4x8l
         /j8AfJKtWRHUCZ3j77wZi7fhULey3GraPiBqkCI24TL3zIG9+qbyomOkQ6kQmYND6z3V
         Qu5Q==
X-Gm-Message-State: APjAAAVPQJMZ7xnkxhBgp3ix0MsYw575qbx6X63lbyYt3u2WqJu1w1zn
        +lejBqCdcg7Ke3OUfgrwYdLYnyYMpkG3RWeGyaNAFg==
X-Google-Smtp-Source: APXvYqzVSJCHAIJzw2Ki3xuEU2OcQ/reJ6yVjoNZ0bCjDZE+rA3BhQAMsiKRSNqwKqr3zDdwk7MKk4vF1gx3otshkzc=
X-Received: by 2002:a5d:8845:: with SMTP id t5mr6046407ios.37.1560942323320;
 Wed, 19 Jun 2019 04:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190521105203.154043-1-darekm@google.com> <16889839-b4e9-9984-2e36-5f07ceb7d7f2@xs4all.nl>
In-Reply-To: <16889839-b4e9-9984-2e36-5f07ceb7d7f2@xs4all.nl>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Wed, 19 Jun 2019 13:05:11 +0200
Message-ID: <CALFZZQEao3vqVxKO-3mT5ATtC=ZWO+bc3dA_Xo-mgpqmna_fMQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] media: cec: expose HDMI connector to CEC dev mapping
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans.

I would like to come back to this thread.

On Fri, May 24, 2019 at 11:21 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Dariusz,
>
> I did some more testing with the Khadas VIM2 and found another problem,
> something that will, unfortunately, require some redesign.
>
> See my comments below...
>
...
>
> Another issue here is that when the HDMI driver removes the notifier,
> then it should also zero the connector info. Remember that both the
> HDMI and the CEC drivers can be loaded and unloaded independently from
> one another.
>

I took a peek at the changes in
https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=cec-conn. Do I
understand it correctly, that the above problem is addressed there by
unregistering an adapter in cec_notifier_conn_unregister (which will
result in /dev/cecX node going away)? I wonder to what degree this
solves the problem of HDMI and CEC drivers being loaded and unloaded
independently. It seems that in cases where HDMI driver is unloaded
and then loaded again, counterintuitively, the /dev/cecX might not
come back again, is this right, or am I missing something? Also, is it
guaranteed that adapter drivers won't try to access an adapter once it
gets removed by cec_notifier_conn_unregister?

Thank you.
