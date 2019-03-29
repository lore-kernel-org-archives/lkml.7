Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB09C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3587218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfC2QJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:09:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45592 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfC2QJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:09:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so2896713qtv.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Am5kpFvsSPcpJZX1iSRCLucd0xEpSf0ByMp99+GyOZc=;
        b=Ml7s5Zzk7cTN9zOJj27V16JaVBIgJ3bvAX4VR6ycowmVWIpfZ5baGFyTHWZa3XhOtq
         rGKXLY5sy3uNYh8vrwOWDd+U0RI4P6yln/O+UzJfDLW53h4RurY2nUV3eN53WQhHYBPO
         zf95MTehgUPcynK8qjjaKQ004f7Ley7pdQYycWvya6amrdo3rjdpJGyuVS0pKiWGYnrU
         Ss9yZk50BQvCYzK38nhLSECChU9IT5TEYDfbAemS6fMQ2l5h4P23H2jybBOh7bivc0KC
         YhohykQV3pdmQdPA4eFByer+laLEKzvGxBs7Ma3HCbgWgJrmnmaASWSRfXq7gH9LSwbo
         kMfw==
X-Gm-Message-State: APjAAAXwVxoprFa9fSeGEQFJHB4+/E4vgKDOvVgMb/3QxF8EUkNKdi+P
        vHbETbBt0RFichYS4FcY6V4hZg==
X-Google-Smtp-Source: APXvYqwPvWlggOCOCZOE++FMeDaYp8mT2DXFtIePYnvadkTVpeTZEstVj+Ou8oCcjYWRclAjhRMeGw==
X-Received: by 2002:a0c:b095:: with SMTP id o21mr8324819qvc.162.1553875771921;
        Fri, 29 Mar 2019 09:09:31 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id r15sm1562334qtb.22.2019.03.29.09.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 09:09:30 -0700 (PDT)
Date:   Fri, 29 Mar 2019 12:09:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, alexander.duyck@gmail.com
Subject: Re: On guest free page hinting and OOM
Message-ID: <20190329120907-mutt-send-email-mst@kernel.org>
References: <20190329084058-mutt-send-email-mst@kernel.org>
 <f6332928-d6a4-7a75-245d-2c534cf6e710@redhat.com>
 <20190329104311-mutt-send-email-mst@kernel.org>
 <7a3baa90-5963-e6e2-c862-9cd9cc1b5f60@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a3baa90-5963-e6e2-c862-9cd9cc1b5f60@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 04:37:46PM +0100, David Hildenbrand wrote:
> Just so we understand each other. What you mean with "appended to guest
> memory" is "append to the guest memory size", not actually "append
> memory via virtio-balloon", like adding memory regions and stuff.
> 
> Instead of "-m 4G" you would do "-m 5G -device virtio-balloon,hint_size=1G".

Right.

