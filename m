Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BA0C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755C620675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA7T20eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfD2QYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:24:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34094 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbfD2QYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:24:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id j6so12663756qtq.1;
        Mon, 29 Apr 2019 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/UgqaWUxLcC8gGmp13yybw0qPVB2rLQrJf42/DjKghA=;
        b=HA7T20eLOs8rd1tDGgNkjEr9zZJqSV/ArHZgiBxI2SEVbKnNfdko8VYcrsBsTvRWRW
         n9mmTPL84xb7SBpfFnXXrOWUgzij2MjbOghSsKfEV1HxcJKbXDzQDT6vfNQfXxh50u35
         X3j1YpqfClMYiZ3+2jvXq5SWRr6IvxpDz66XFNrjBmNvQCE9cl3k0uCah/cUzlmTtZxL
         rRSAinfkFS0074HfXy7+GOSnfFSq2YdnoNchj5ycTgLD/iw8S/zl+LDQs6eaO9qW6oWS
         GGyVYZauKeDI1r/M/BAQvKbaQsoUqZeyhe6uXtrKN9fcfyyUUxh2iXX8C87uj3zFMu5z
         5dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/UgqaWUxLcC8gGmp13yybw0qPVB2rLQrJf42/DjKghA=;
        b=lITCa93K7pa/w6kjFlyUrkoATqHNNd/Lw4poYNzFOlbT5PnviH+GnodJYdYNMBBX/e
         WK2BZUsWtTI5kd4DQy6geVeIrlmPrRdINajs0Bbwl5r2zflEVPHI1j9ixvUcOI2IUQe2
         n3TW+8tVEwgjpRJ8Ga3QflGBXNclqOP3+9+I3dIcszuTDY/P0LTn2y7KBukRKCb+k3pu
         mXL++Wsrve2GI+cQeO/GVQ1+yGDfpzXbS+Huzv6uB4nHOdvIR1SQrk2g4b3mo6ZynV+L
         GpFHG0jsHMLOzCwCpyqkQXW0CJ6IQWDjM0jew7gh+j230KkjZag5Q/ec+ZXF3mk6sbpV
         xa3Q==
X-Gm-Message-State: APjAAAU8rfMFo0g+wkipEOMk5p3Mhht31Cy+pojF0camZ0Sc8N/viPEe
        sV04dcgMlCv4RACs2HIqhQKSlXyPwBm2tWajUc4=
X-Google-Smtp-Source: APXvYqyThClpmkzcWrMn8TCFfVrAhf3rhXeBpEHCLIlLSmM7WMewnl14CXSI9pG/58YiSgCB/6F2piTt91krXqtAMCE=
X-Received: by 2002:a0c:89c5:: with SMTP id 5mr5827397qvs.240.1556555043841;
 Mon, 29 Apr 2019 09:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190427091943.GA3810@haolee.io> <20190429143117.GA1474@kroah.com>
In-Reply-To: <20190429143117.GA1474@kroah.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Tue, 30 Apr 2019 00:23:50 +0800
Message-ID: <CA+PpKPmFzLcE=gBwB9q0UNF1Rt1KU7_q3p9xyL-mh9g=imm22Q@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: 8250: Fix type field in format string
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 at 22:31, Greg KH <gregkh@linuxfoundation.org> wrote:
> This causes build warnings when applied, I'm having to drop it now.
>
> Please be more careful, when submitting patches, always test-build them
> first.

I have found my mistake. Although I have built a kernel to test my
patch, I forget to turn on the 8250 configurations which are turned
off during another kernel test. As a result, 8250_pnp.c was not
compiled at all, so I didn't see any warnings. Sorry for that and
thanks for your guidance. I will submit my patch v3.
