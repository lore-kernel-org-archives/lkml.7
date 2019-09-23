Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D03C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9923F20835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHShKYYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393887AbfIWLbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:31:47 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:38838 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389652AbfIWLbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 07:31:47 -0400
Received: by mail-vs1-f52.google.com with SMTP id b123so9167059vsb.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BdkRnPxxkrHCArqVLcv4NrTAprv0oT6sz0IuGcvvVWE=;
        b=jHShKYYf94iD2ATPmGI2XwDkf0OHLQT3BApISGPlbJKzIY/Q2WZFIfr/SrU/pSqLy4
         paP0exW8nos30hYID3RxxM07msiA2p4tGi1oGCgGaTRJD+1GsAlPbtQs1/I3wrRE/ggm
         6DW2dpV9BTs8xzduRSMoGvUdmXE6fMYXj/Rj27mSMZCDoJNGxhvUa1N4s9dFPImX0oCM
         c9LgFKMOlUa+06PbMPbaaZrmsmxpN+QK76856pLUs+30YH/dDa71oDehFcJntogH3mwm
         caBSsrQ+DLoxSAm0j05GPi+6pLZknm+mIXXZRQPgx8N9HVfIyEbPZ9UeQfSzCFs4l606
         i/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BdkRnPxxkrHCArqVLcv4NrTAprv0oT6sz0IuGcvvVWE=;
        b=gcWbe5FsNCicjt0fYeG+LxgnHqQU3gvG3THQ2PaumtnDhmuFGUSBdZS5zmGT+SH38B
         UkgBU5sH/0PyVBOaAxp2yyHf6FqSp5epKIDDtnVFMcfVAXrBktpa4dDfA/g08vJAU+n3
         y79w2lW5ASjhR0oVkVLGfrBSEe2ocX5owoSva4k/EMVLiHkcbzxY3rEOqZQn19yzOoVg
         NPRNZPtWG49d1acs9hdRMhvvuJNtpmlvyswpSII7ImWHRcCIgMbwqnX3r1FejGCd/VST
         0YOjiwgN3JvMN2ryYIFMkEbiN0i9zL3xv8QjYCT9qZHeq3Fs48lfGarDUvtfcrMiIqMT
         fKhw==
X-Gm-Message-State: APjAAAUtnf+nkcX3wHYCuVEtyCmUAde1zPS9rZyOj65Ei+P4D3ybMRJ3
        cgghxFjccIHHICUiQGrheI/CGWz0gPqCUed6wUMigw==
X-Google-Smtp-Source: APXvYqy8BKdp4ghbBvtWW9phg6fsERCN3I2yGXJ7bam9mOb5SLVGmAxWSC7FMsadphb/GL8lp0NrqknQC51A6f45XLU=
X-Received: by 2002:a67:f0cd:: with SMTP id j13mr9479486vsl.183.1569238306236;
 Mon, 23 Sep 2019 04:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
In-Reply-To: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 23 Sep 2019 04:31:09 -0700
Message-ID: <CAKOZuetMK0eRxBrR8wXo_qCaQ7OGKQHqAy15cX437+Q+cvbbvA@mail.gmail.com>
Subject: Re: For review: pidfd_send_signal(2) manual page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 2:12 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>        The  pidfd_send_signal()  system call allows the avoidance of race
>        conditions that occur when using traditional interfaces  (such  as
>        kill(2)) to signal a process.  The problem is that the traditional
>        interfaces specify the target process via a process ID (PID), with
>        the  result  that the sender may accidentally send a signal to the
>        wrong process if the originally intended target process has termi=
=E2=80=90
>        nated  and its PID has been recycled for another process.  By con=
=E2=80=90
>        trast, a PID file descriptor is a stable reference to  a  specific
>        process;  if  that  process  terminates,  then the file descriptor
>        ceases to be  valid

The file *descriptor* remains valid even after the process to which it
refers exits. You can close(2) the file descriptor without getting
EBADF. I'd say, instead, that "a PID file descriptor is a stable
reference to a specific process; process-related operations on a PID
file descriptor fail after that process exits".
