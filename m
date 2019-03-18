Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39309C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0866F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3+md7ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfCRWLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:11:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35901 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfCRWLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:11:55 -0400
Received: by mail-io1-f68.google.com with SMTP id f6so15969531iop.3;
        Mon, 18 Mar 2019 15:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3B1DyfFNEVWJu12Dl72jqSuZFJlZe53Z3WE/MCPyDJA=;
        b=e3+md7ezv8TkhJLEHXpTr5bH/5y2eRNa3yZd9YRFrdfX8gUpcQeVwpLaI7Bp2xTZIe
         67dr2nAP4lGzn1fdHEfr8ucE2+hORob9UmjTghNi0Q/gT2mR1pDsZItuQqWsRmBNPxYw
         UgnWcyPCKkxtOg99HvVYH+eTamfYnGNfpczT2agGCfBzrUt/DjR6/VSG0iEEN4+a/Rf6
         /k6TcC3I76FOD3qQte9iFVROczEQ1FQD+dbyHk/U/8dFtTNbKWmp9jX7rKkNTqoRbCWg
         yVLD9JeWLZL+DU672p2fdWUM6AN+Ea6LTC2pId04LLbKwUopgeGi+bnc9M12HgclysQl
         EVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3B1DyfFNEVWJu12Dl72jqSuZFJlZe53Z3WE/MCPyDJA=;
        b=Jfa5p7zavY+FYF96BDCvOzVemyJT4VNBCHqIJ61qYTnQgFgCdvENWCVEeQ+2iiuSnK
         EbUwl9Z96rgG9P2T9vvLf0rmLFO10VGUNoRjPw7+8b+jU0xG71W/io7sZrrkubdKzL82
         st4OM+kYlcLbIbHWJwLKCd1OBncELDivXPQP9+Y3QKbFp78rv1vKu4Bkk+ycNIrPpCVy
         5DhBaVYksS9Mp3zlVdM27osylVn4lgmruoZwUi4ZFSAC6jaw498gz+qpVJdH2RCu054d
         k1hcOcxFAvcyIuRVGXcgO7FB4TJMSJep/1vWHQpPvQ4vOzawYwAYG8Xd6JqTpD6sizK8
         3mCA==
X-Gm-Message-State: APjAAAXbdHNuqvmGnCsI+qJnYjhOb6/unuAvWlpqxOi2UQGcRhF9GvAY
        6/nKX72sm2OaIDi9oj+ru7aPnRicQa3C5c4gFnVxLZvj
X-Google-Smtp-Source: APXvYqxJvsckQiFqdUA+oLW4kk2sK879l1yvPlzLh5ku/Oy8DvFQH+os+e4+CJTyetRDWo+ggv4b2LfLMwC/0mD/+yM=
X-Received: by 2002:a5d:8555:: with SMTP id b21mr13772498ios.203.1552947114208;
 Mon, 18 Mar 2019 15:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <CADBGO7_WUoA53gM8EDFy6Q36SDEZPU9V=OUBA0QM20FOko51Rg@mail.gmail.com>
In-Reply-To: <CADBGO7_WUoA53gM8EDFy6Q36SDEZPU9V=OUBA0QM20FOko51Rg@mail.gmail.com>
From:   Paul Zimmerman <pauldzim@gmail.com>
Date:   Mon, 18 Mar 2019 15:11:28 -0700
Message-ID: <CADBGO7_GcPvtcBu_Oj+y4M1RBNc7Bb7UueghkLK=u293V+AYmw@mail.gmail.com>
Subject: Re: Regression in suspend-to-ram (TPM related) with 5.1-rc1
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 2:39 PM Paul Zimmerman <pauldzim@gmail.com> wrote:

< snip >

> It takes about 45 minutes to do a full kernel rebuild on this machine,
> so doing a full bisection would be a little painful.

Actually, that was because I had the Linux disk attached via USB. I have it
connected internally now, and a full kernel rebuild only takes about 8 minutes.
So I can do a bisection if required.

-- Paul
