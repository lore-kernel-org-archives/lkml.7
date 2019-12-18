Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04896C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27B2218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkRR4r8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLRQcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:32:18 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36592 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfLRQcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:32:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so1314256oic.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 08:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJ75419XvZRHR0rexZDkctiNEKDNBBVNBy1GUVt8Qa0=;
        b=XkRR4r8kzwBubq9wIeO5DTnnXv2kVWLFzVr5HFX1Wm/LZ0mpL6biyoUrgKbhpFRtpR
         BorQ8QDc89QWLtMtpY92RJ8Txpmrjt8842xIZWUTyusMfdWTcLebzyXTJodX80dTPQ7v
         19cpjbzxaf3b//zEVd29T9B16q0Qrd8NMbE1jkuNi2CluS7m36dn0FhLW62NCMFHc1bm
         KvD/KIJioCnaTvOBir+z7dNC/iiboHxtlEK1PAy/tIdRsBwJa30z03hytmjPS+kw0vqB
         d3LQ7Ggqt64RD/RhGHLghiBkjwWxAUbwsLZlDgG1eBGqqd79/sZcOGs/rEhhs7+C0ey/
         2Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJ75419XvZRHR0rexZDkctiNEKDNBBVNBy1GUVt8Qa0=;
        b=ePRCJizO/rftlU+NTxvoua8OSW/C4f9lEXV0Yig+NeiTKstGqlXMYGWrklQhJN9FjA
         aIpU1HMfADkwPzuu1hmME8JhmhRhS+h9tIaRMv6JJ8lARfrsB4Xakmy4h5LaFHVSuYhF
         a5ot4vGkb6cR7u82LQXs+mdcpIe3aRDLGXfYrIxnXQkpt8Xwz+ZTrEN0vJi8XGsdLq7G
         aG2zOT//ObQgCZwXjQ7uUSgnJuHc5nWD55VzGmPeZoSwaagPxKkL9udJUKjj+aPqxcSD
         MRYMeftUrn4+pqskdaLoWbAeh5O6319mqTAcJqMYGWhvbGEYz7OFoBDCOa4K/IOJsZq5
         sqVA==
X-Gm-Message-State: APjAAAVzqeESYfdcqBer8AZlw7/hNvzT5ZUjdFEXc9L7iL40d39nleIo
        Fiz9Wi1yl2yVHlIxHdtK/DZuGGJW7kwTNynaPNZgLA==
X-Google-Smtp-Source: APXvYqwFIYfEHaFJ3WieSZWI8iqHiZqYIVt7yNLVI4WEhds3JiNLGQxWq9i9KnEiiWeTVv6Q+WFsVtUllvOV0J4o/GU=
X-Received: by 2002:aca:c692:: with SMTP id w140mr951036oif.139.1576686737600;
 Wed, 18 Dec 2019 08:32:17 -0800 (PST)
MIME-Version: 1.0
References: <e8f9744ddffc4527b222ce72d41c61a1@AcuMS.aculab.com> <20191217173403.61f4e2d8@gandalf.local.home>
In-Reply-To: <20191217173403.61f4e2d8@gandalf.local.home>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 18 Dec 2019 16:31:41 +0000
Message-ID: <CADVatmN-5W5J=dn1y9fuuV32bE-NmUpEd8983KLO3Jsf0d5G4g@mail.gmail.com>
Subject: Re: ftrace trace_raw_pipe format
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:34 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 17 Dec 2019 17:44:40 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
>
> > I'm trying to 'grok' the trace_raw_pipe data that ftrace generates.
> > I've some 3rd party code that post-processes it, but doesn't like wrapped traces
> > because (I think) the traces from different cpus start at different times.
> >
<snip>
>
> You may want to use libtraceevent (which will, hopefully, soon
> be in debian!). Attached is a simple program that reads the data using
> it and prints out the format.

merge request has been opened in debian, waiting for the debian
kernel-team to review and merge it,


-- 
Regards
Sudip
