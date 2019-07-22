Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E87C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE29218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eCJDQVgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfGVQEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:04:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42127 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbfGVQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:04:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id h18so39025011qtm.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vwvk1p704PvrHoU3x+syVrBIr03+GtruOtffq5nOmqI=;
        b=eCJDQVgp/TUa3SJDw5YNpJdxoRLDUf0uKWF8HiEN2E6tOilw6te7IXdJ74mZFUYqp/
         9cs4iQsc0KiVAOncyf/4OEnDeZsuNdAdxwUKQmiZzySVbAR5OjTuhXiGRkV1rgBYswjM
         IQx0Ulu4NMDBwDAviDS9g4pKXJW+xpv+Iy8d6aVLlz84ufr1JzYd1aeEamQT0VorPgKU
         QT1i21qMa2c8H2+8UBfm4o25QcGgTYS7VKw/3eTMHAe7UkpWzGXLekAdlCSWusHGhsa8
         cEkwa4My8xWUN30i19bWw4qGMFPnC91vuvyuUJqr/Slt5ziIHR7WpgLw+5d/ULuZjsfk
         lFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vwvk1p704PvrHoU3x+syVrBIr03+GtruOtffq5nOmqI=;
        b=fGti9HJ5QufHUazqB18gmViIsVf5QmZnRfLDZ4mH5pKFj9tZsHmN6YQi6oVqdEvruR
         HnFrsaoIysQOVlWJEavzLgGvlQ0kxElo2ATvnyltEO+o0KLamI8zx/HQbrtMHiF4c+qo
         NdQRHinV5tMlCRUiLsB8oKp6iyN3s8KOpKx7afsxzvWL8F17WQPv/WJ5RdBfmLwRBFzO
         u3uLv261byFeYHQA+9IKd3HoHInKc76kfhrd7ROlGSN+FPZAEOcyUHY0tgixdmVZHX87
         0iIFaFpnWep2yma2mUKrtJfrBycbNZi8Zt2g1R6nzc/zg8A0LIOrucCf7z520qPV5yUn
         zZKQ==
X-Gm-Message-State: APjAAAV+b1jPXEPV/x4+VGVnXi4SRKK3klewx1m7e1zLuwXHXoK9bXP5
        cbYC3HhOD5XwC3GMRsbRDt0L9w==
X-Google-Smtp-Source: APXvYqwAqmiUCOGD8gRTdb/gKf382wokrezGvhSEToPpHN31WEGoX97JjGxgPReHba9ZDH0CrbO+rw==
X-Received: by 2002:ac8:431e:: with SMTP id z30mr50035442qtm.291.1563811490053;
        Mon, 22 Jul 2019 09:04:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y3sm20100502qtj.46.2019.07.22.09.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 09:04:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpanw-00059A-U7; Mon, 22 Jul 2019 13:04:48 -0300
Date:   Mon, 22 Jul 2019 13:04:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, aarcange@redhat.com,
        akpm@linux-foundation.org, christian@brauner.io,
        davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: RFC: call_rcu_outstanding (was Re: WARNING in __mmdrop)
Message-ID: <20190722160448.GH7607@ziepe.ca>
References: <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081933-mutt-send-email-mst@kernel.org>
 <20190721131725.GR14271@linux.ibm.com>
 <20190721210837.GC363@bombadil.infradead.org>
 <20190721233113.GV14271@linux.ibm.com>
 <20190722035042-mutt-send-email-mst@kernel.org>
 <20190722115149.GY14271@linux.ibm.com>
 <20190722134152.GA13013@ziepe.ca>
 <20190722155235.GF14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722155235.GF14271@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 08:52:35AM -0700, Paul E. McKenney wrote:
> So why then is there a problem?

I'm not sure there is a real problem, I thought Michael was just
asking how to design with RCU in the case where the user controls the
kfree_rcu??

Sounds like the answer is "don't worry about it" ?

Thanks,
Jason
