Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EE3C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 18:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52EB206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 18:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLaSC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 13:02:27 -0500
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:39311 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbfLaSC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 13:02:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 60D1718224D8D;
        Tue, 31 Dec 2019 18:02:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: song33_3208bae3f8801
X-Filterd-Recvd-Size: 2662
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 31 Dec 2019 18:02:23 +0000 (UTC)
Message-ID: <a6911ca13419af48d7170e4426cd23f22a2824f5.camel@perches.com>
Subject: Re: [PATCH v8 10/13] exfat: add nls operations
From:   Joe Perches <joe@perches.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Date:   Tue, 31 Dec 2019 10:01:36 -0800
In-Reply-To: <5b0febd5-642b-83f2-7d81-7a1cbb302e3c@web.de>
References: <20191220062419.23516-11-namjae.jeon@samsung.com>
         <5b0febd5-642b-83f2-7d81-7a1cbb302e3c@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-31 at 15:23 +0100, Markus Elfring wrote:
> …
> > +++ b/fs/exfat/nls.c
> …
> > +int exfat_nls_cmp_uniname(struct super_block *sb, unsigned short *a,
> > +		unsigned short *b)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < MAX_NAME_LENGTH; i++, a++, b++) {
> > +		if (exfat_nls_upper(sb, *a) != exfat_nls_upper(sb, *b))
> 
> Can it matter to compare run time characteristics with the following
> code variant?
> 
> +	for (i = 0; i < MAX_NAME_LENGTH; i++) {
> +		if (exfat_nls_upper(sb, a[i]) != exfat_nls_upper(sb, b[i]))

Markus, try comparing the object code produced by the compiler first,
it's likely identical.

If this is actually a performance sensitive path, it might improve
runtime by having 2 code paths to avoid the testing of
sbi->options.case_sensitive for each u16 value in the array.

Something like: (uncompiled, untested, written in email client)

static inline
unsigned short exfat_sbi_upper(struct exfat_sb_info *sbi, unsigned short a)
{
	if (sbi->vol_utbl[a])
		return sbi->vol_utbl[a];
	return a;
}

int exfat_nls_cmp_uniname(struct super_block *sb,
			  unsigned short *a,
			  unsigned short *b)
{
	int i;
	struct exfat_sb_info *sbi = EXFAT_SB(sb);

	if (!sbi->options.case_sensitive) {
		for (i = 0; i < MAX_NAME_LENGTH; i++, a++, b++) {
			if (exfat_sbi_upper(sbi, *a) != exfat_sbi_upper(sbi, *b))
				return 1;
			if (*a == 0x0)
				return 0;
		}
	} else {
		for (i = 0; i < MAX_NAME_LENGTH; i++, a++, b++) {
			if (*a != *b)
				return 1;	
			if (*a == 0x0)
				return 0;
		}
	}

	return 0;
}


