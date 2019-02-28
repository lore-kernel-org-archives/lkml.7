Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70452133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733237AbfB1XME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:35950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733049AbfB1XME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB2FEB158;
        Thu, 28 Feb 2019 23:12:02 +0000 (UTC)
Date:   Fri, 1 Mar 2019 00:12:02 +0100
From:   Jiri Bohac <jbohac@suse.cz>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Omar Sandoval <osandov@fb.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3] x86/gart/kcore: Exclude GART aperture from kcore
Message-ID: <20190228231202.3wvojgxscrodoalt@dwarf.suse.cz>
References: <20190213082800.4400-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213082800.4400-1-kasong@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:28:00PM +0800, Kairui Song wrote:
> @@ -465,6 +472,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  				goto out;
>  			}
>  			m = NULL;	/* skip the list anchor */
> +		} else if (m->type == KCORE_NORAM) {
> +			/* for NORAM area just fill zero */
> +			if (clear_user(buffer, tsz)) {
> +				ret = -EFAULT;
> +				goto out;
> +			}

I don't think this works reliably. The loop filling the buffer
has this logic at the top:

        while (buflen) {
                /*
                 * If this is the first iteration or the address is not within
                 * the previous entry, search for a matching entry.
                 */
                if (!m || start < m->addr || start >= m->addr + m->size) {
                        list_for_each_entry(m, &kclist_head, list) {
                                if (start >= m->addr &&
                                    start < m->addr + m->size)
                                        break;
                        }
                }

This sets m to the kclist entry that contains the memory being
read. But if we do a large read that starts in valid KCORE_RAM
memory below the GART overlap and extends into the overlap, m
will not be set to the KCORE_NORAM entry. It will keep pointing
to the KCORE_RAM entry and the patch will have no effect.

But this seems already broken in existing cases as well, various
KCORE_* types overlap with KCORE_RAM, don't they?  So maybe
bf991c2231117d50a7645792b514354fc8d19dae ("proc/kcore: optimize
multiple page reads") broke this and once fixed, this KCORE_NORAM
approach will work. Omar?

Regards,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

