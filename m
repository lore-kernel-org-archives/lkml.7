Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C30EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36236217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbfDQVNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:13:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50786 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDQVNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:13:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGrrc-0007nC-4E; Wed, 17 Apr 2019 21:13:04 +0000
Date:   Wed, 17 Apr 2019 22:13:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Ostrowski <mostrows@earthlink.net>,
        Dmitry Kozlov <xeb@mail.ru>,
        James Chapman <jchapman@katalix.com>,
        linux-ppp@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 02/26] compat_ioctl: move simple ppp command handling
 into driver
Message-ID: <20190417211303.GU2217@ZenIV.linux.org.uk>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416202013.4034148-3-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:19:40PM +0200, Arnd Bergmann wrote:
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index c708400fff4a..04252c3492ee 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -899,6 +899,7 @@ static const struct file_operations ppp_device_fops = {
>  	.write		= ppp_write,
>  	.poll		= ppp_poll,
>  	.unlocked_ioctl	= ppp_ioctl,
> +	.compat_ioctl	= ppp_ioctl,

Oh?  What happens on e.g. s390 with something like PPPIOCNEWUNIT?
Current kernel:
	* no ->compat_ioctl()
	* ->unlock_ioctl() is present
	* found by compat_ioctl_check_table()
	* pass (unsigned long)compat_ptr(arg) to do_vfs_ioctl()
	* pass that to ppp_ioctl()
	* pass that to ppp_unattached_ioctl()
	* fetch int from (int __user *)compat_ptr(arg)

With your patch:
	* call ppp_ioctl()
	* pass arg to ppp_unattached_ioctl()
	* fetch int from (int __user *)arg

AFAICS, that's broken...  Looking at that ppp_ioctl(),
pointer to arch-independent type or ignored:
	PPPIOCNEWUNIT PPPIOCATTACH PPPIOCATTCHAN PPPIOCSMRU PPPIOCSFLAGS
	PPPIOCGFLAGS PPPIOCGUNIT PPPIOCSDEBUG PPPIOCSMAXCID PPPIOCCONNECT
	PPPIOCGDEBUG PPPIOCSMAXCID PPPIOCSMRRU
	PPPIOCDETACH PPPIOCDISCONN
	PPPIOCGASYNCMAP PPPIOCSASYNCMAP PPPIOCGRASYNCMAP PPPIOCSRASYNCMAP
	PPPIOCGXASYNCMAP PPPIOCSXASYNCMAP
	PPPIOCGNPMODE PPPIOCSNPMODE
pointer to struct ppp_option_data (with further pointer-chasing in it):
	PPPIOCSCOMPRESS
pointer to struct ppp_idle:
	PPPIOCGIDLE
pointer to struct sock_filter (with hidden pointer-chasing, AFAICS):
	PPPIOCSPASS PPPIOCSACTIVE

Pretty much all of them take pointers.  What's more, reaction to
unknown is -ENOTTY, not -ENOIOCTLCM, so that patch will have
prevent the translated ones from reaching do_ioctl_trans()

What am I missing here?  Why not simply do

compat_ppp_ioctl()
{
	PPPIOCSCOMPRESS32 => deal with it
	PPPIOCGIDLE32 => deal with it
	PPPIOCSPASS32 / PPPIOCSACTIVE32 => deal with it
	default: pass compat_ptr(arg) to ppp_ioctl() and be done with that
}

with BPF-related bits (both compat and native) taken to e.g. net/core/bpf-ppp.c,
picked by both generic and isdn?  IDGI...
