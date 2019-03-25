Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6457FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3583D206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553550551;
	bh=YP+4jCJe+3hmTnthKsurSAmXTcpiFw+m5kocmNNY9ic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NNiLYfd/aMDCvreoUzbFoNwg/293WppW3hVQoYHG9L6EMjqJgwWWQ1c4NxKqqp97y
	 z1MbWamI1Z/sl2fPASDpWaneMwy7vSBlhihrJTe9Dy571Y/gj1LRRVBf9oRsG6kF5+
	 4uxOEKwDx72EllUx6HlBjjKXk0VX1+d9BO1FDV+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfCYVtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:49:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44465 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfCYVtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:49:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so4786144ljg.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjC4FefRjynjGz6uxUgdOSrnwcNFHtL99Ux4C4saYQc=;
        b=HStATVuEJZct9Vnen+zXrNuBDKdQPn3ypVW7H7L/RtdQFhdfBQF1OOZ9NlPE6AsU8R
         +X7dwZl9P6iZhsT2qbKiSVQDOmEj1R8k1Bi8DlAKniDrFyiWNlqjSF3EJKYGhquTJ2HB
         E+QLeDUvwGjASkh6y26ZiQHoxlw4H0FKpJxFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjC4FefRjynjGz6uxUgdOSrnwcNFHtL99Ux4C4saYQc=;
        b=W2v0pk2OFDAYIStbB9VFyDfBxg6zHXw0J05VuPrQPn/eZtYGFeUkZzQ3mDyN0tYGSv
         Mt1NMxF1mAVTslkiugvlsdexL2nruVkXA3DPMFcKNBJaHfa3dZY7s0IR0X04IctMMwYc
         lB10v458ZeUguU+hE8GU+cYWxxsWQ0875S7MP1GcnTNRba4fzg4JQnlPb7SiPxa/HP5e
         By2aQAkNwb1FWPNA2+dtgkaVfPxXTs0GJJSkaq9zwOzvKk2TvDKZTI2V/WhOrRMRF4U2
         ILbcUsPRtSba+6qvk2hNkVMKtnm7MUEIK3W5wU6VDm88KFPpggWxePb2eHJNTVgNOhwD
         YGEw==
X-Gm-Message-State: APjAAAUvEKieL7D7icG6CnO1By+oQ3L7zM6QQ/1CZNUbSZx6WLJR8Yvp
        0JU4uwspDHuW8FRaq5uX090EFS1n4Og=
X-Google-Smtp-Source: APXvYqzMEXhPoyL6KKX+EHvuXO4cBuRF0b5XewUeduQTowy1J6DAkTrxv3vjI450ZstsD0QRJSPfsg==
X-Received: by 2002:a2e:4504:: with SMTP id s4mr14443022lja.150.1553550547106;
        Mon, 25 Mar 2019 14:49:07 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j28sm3782743lfh.81.2019.03.25.14.49.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:49:06 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id d18so7144732lfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:49:06 -0700 (PDT)
X-Received: by 2002:ac2:4203:: with SMTP id y3mr13356492lfh.11.1553550545874;
 Mon, 25 Mar 2019 14:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190325211325.21411-1-sudipm.mukherjee@gmail.com>
In-Reply-To: <20190325211325.21411-1-sudipm.mukherjee@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Mar 2019 14:48:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+3Hrg=2BLd0kVN6FjDCB6K1sMY0pYBxq3gFzdiYUe1w@mail.gmail.com>
Message-ID: <CAHk-=wg+3Hrg=2BLd0kVN6FjDCB6K1sMY0pYBxq3gFzdiYUe1w@mail.gmail.com>
Subject: Re: [PATCH] parport: daisy: do not try to load lowlevel driver
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 2:13 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> We do not need to search for ports and bind the initial list of ports
> to daisy driver as daisy driver is always the first driver to use the
> new found parport and we know when the parport bus is registering the
> list of parport will always be empty. So, proceed with the daisy_drv
> registration even if the list of parport is empty.

This is completely hacky and senseless.

The problem as far as I can tell is that the daisy driver shouldn't
register early at all, and shouldn't be a subsys initcall. It should
just be a driver initcall, and happen naturally after the parport
subsystem has been initialized.

This patch just makes the code even *less* understandable.

I'm going to revert that problematic commit.

If you can get it working without that incorrect and senseless tie-in
of the daisy driver registration with the regular partport init
sequence, we can revisit this.

                      Linus
