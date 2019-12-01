Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65645C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BA32082E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 19:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575230111;
	bh=uDAjsmhTd5XWfBka2mUWuyjsLvyNlceDVbkaCoEl3ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c+9u/9CbJ1XEL+hwM6VrWhFenXeRfAY2PHQMLG8p/RuOrYMQtwrw9BaPw5CWkTj+X
	 9kx73L5S7/pqLds6gA1C/OISTKwcPmSUJZMgE3gkyCB0bJIpy2hcpjIvaTa2MjbZJ1
	 iCZrRZBJm126bTLYMUgjzl/HoqfkDBAKyIgbDnTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfLATxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 14:53:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35189 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfLATxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 14:53:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id u8so5192187wmu.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6PgSdoZWpo1JMqZRuW8ir5OpMVyk/64oGX4SPvLgA14=;
        b=FOYtdI+KLEt9wwXOYTg1NNlWEy2KFnSePqneMHt+1UGDrij51hy4oSSBgKYluIFrGM
         A+v6Sa2cMkxXKvTrO1koMVpiuZLszaYAgT65rhVcPMxx+nuWU2u5YkaXFJ5L/w2YoWD4
         eRHBOJGZD2srci1066cyvkq8LfCWXVUzbElY8y8qqoPEpcbp4uRN7saxuX2VPZkGzWgw
         Bv3dsBe29PlBj5OcCaDB/s7rmWZgy770yOKbp5IRx+WCJpc3ERuevwUtyzYXpSXzveTF
         zC04cVks/f683aJrfyP94CztP/5YuxQOGB4j/fT79ZX/7RyWI5HoSObSnQlq7EYG5H5Y
         z/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6PgSdoZWpo1JMqZRuW8ir5OpMVyk/64oGX4SPvLgA14=;
        b=GkOWcsyJrkRDJEsdE2nDw8FcAQa/FqYzS6tu78SI2z8DvSmklMs2YxsfTR+8K1E1rD
         TMKSHPblJ46hs84UMT8Xg6hxvDFhvgzYEkAnsILSIinv7/RYXZzBXDbPqyD+gBIRdO9b
         PHd7fycZCReFHgKUVvkkQq/zjDGtA4vrGdM52YNz2Ah88IEB+bjLU3od9IiSq7JU4oTx
         JFdxbL753SIdOtCzPkx8rsx+PS6MQnf14HvrtUzYBeA7sLrd00Nv+98NqR5nh3/emEQT
         VkIkd//PCPykTyO0P53tjiNjSRTF7wcRkad0MtHZWCjUJTYRAzGqINYJNVgLl9Stbv0/
         7+Bg==
X-Gm-Message-State: APjAAAXl7DdJTJ0fVFey1fWS8nnoUNZh+eIRMUCtDBoUnUlF574NRZR1
        SwYRPlFDgR/H+TRhhxzSrIc=
X-Google-Smtp-Source: APXvYqyjK4nUKJj7/qleIujhJ4OCYV9urf3SgkT3d/mH/iSnw4fm4CEABcYw5TnRVvPhRrFjF680Bw==
X-Received: by 2002:a7b:c552:: with SMTP id j18mr8544208wmk.123.1575229998501;
        Sun, 01 Dec 2019 11:53:18 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o4sm11319711wrw.97.2019.12.01.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 11:53:17 -0800 (PST)
Date:   Sun, 1 Dec 2019 20:53:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mariusz Ceier <mceier@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <rong.a.chen@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search
Message-ID: <20191201195315.GB3615@gmail.com>
References: <20191127005312.GD20422@shao2-debian>
 <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
 <20191130212729.ykxstm5kj2p5ir6q@linux-p48b>
 <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
 <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com>
 <20191201104624.GA51279@gmail.com>
 <20191201144947.GA4167@gmail.com>
 <CAJTyqKPUhQR_DjSkMs3s9YSWA-tQXQvtnLqzxF353W9nnQ2cLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJTyqKPUhQR_DjSkMs3s9YSWA-tQXQvtnLqzxF353W9nnQ2cLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mariusz Ceier <mceier@gmail.com> wrote:

> Your patch fixes performance issue on my system and afterwards
> /sys/kernel/debug/x86/pat_memtype_list contents are:

Great, thanks for testing it!

> PAT memtype list:

> uncached-minus @ 0xfed90000-0xfed91000
> write-combining @ 0x2000000000-0x2100000000
> write-combining @ 0x2000000000-0x2100000000
> uncached-minus @ 0x2100000000-0x2100001000

Note how the UC- region starts right after the WC region, which triggered 
the bug on your system.

> It's very similar to pat_memtype_list contents after reverting 4
> x86/mm/pat patches affecting performance:
> 
> @@ -1,8 +1,8 @@
>  PAT memtype list:
>  write-back @ 0x55ba4000-0x55ba5000
>  write-back @ 0x5e88c000-0x5e8b5000
> -write-back @ 0x5e8b4000-0x5e8b8000
>  write-back @ 0x5e8b4000-0x5e8b5000
> +write-back @ 0x5e8b4000-0x5e8b8000
>  write-back @ 0x5e8b7000-0x5e8bb000
>  write-back @ 0x5e8ba000-0x5e8bc000
>  write-back @ 0x5e8bb000-0x5e8be000
> @@ -21,8 +21,8 @@
>  uncached-minus @ 0xec260000-0xec264000
>  uncached-minus @ 0xec300000-0xec320000
>  uncached-minus @ 0xec326000-0xec327000
> -uncached-minus @ 0xf0000000-0xf0001000
>  uncached-minus @ 0xf0000000-0xf8000000
> +uncached-minus @ 0xf0000000-0xf0001000

Yes, the ordering of same-start regions is different. I believe the 
difference is due to how the old rbtree logic inserted subtrees:


-       while (*node) {
-               struct memtype *data = rb_entry(*node, struct memtype, rb);
-
-               parent = *node;
-               if (data->subtree_max_end < newdata->end)
-                       data->subtree_max_end = newdata->end;
-               if (newdata->start <= data->start)
-                       node = &((*node)->rb_left);
-               else if (newdata->start > data->start)
-                       node = &((*node)->rb_right);
-       }
-
-       newdata->subtree_max_end = newdata->end;
-       rb_link_node(&newdata->rb, parent, node);
-       rb_insert_augmented(&newdata->rb, root, &memtype_rb_augment_cb);

In the new interval-tree logic this is:

        while (*link) {                                                       \
                rb_parent = *link;                                            \
                parent = rb_entry(rb_parent, ITSTRUCT, ITRB);                 \
                if (parent->ITSUBTREE < last)                                 \
                        parent->ITSUBTREE = last;                             \
                if (start < ITSTART(parent))                                  \
                        link = &parent->ITRB.rb_left;                         \
                else {                                                        \
                        link = &parent->ITRB.rb_right;                        \
                        leftmost = false;                                     \
                }                                                             \
        }                                                                     \
                                                                              \
        node->ITSUBTREE = last;                                               \
        rb_link_node(&node->ITRB, rb_parent, link);                           \
        rb_insert_augmented_cached(&node->ITRB, root,                         \
                                   leftmost, &ITPREFIX ## _augment);          \

The old logic was a bit convoluted, but it can be written as:

                if (newdata->start <= data->start)
                        node = &parent->rb_left;
                else
                        node = &parent->rb_right;

The new logic is, in effect:

                if (start < data->start)
                        link = &parent->rb_left;
                else
                        link = &parent->rb_right;

Note the "<=" vs. '<' difference - this I believe changes the ordering 
within the tree. It's still fine as long as this is used consistently, 
but this changes the internal ordering of the nodes of the tree.

Thanks,

	Ingo
