Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD40C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36892214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbfDQXxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:53:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52892 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDQXxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:53:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGuMO-0002nr-SI; Wed, 17 Apr 2019 23:53:01 +0000
Date:   Thu, 18 Apr 2019 00:53:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Ostrowski <mostrows@earthlink.net>,
        Dmitry Kozlov <xeb@mail.ru>,
        James Chapman <jchapman@katalix.com>,
        linux-ppp@vger.kernel.org, Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 02/26] compat_ioctl: move simple ppp command handling
 into driver
Message-ID: <20190417235300.GB2217@ZenIV.linux.org.uk>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-3-arnd@arndb.de>
 <20190417211303.GU2217@ZenIV.linux.org.uk>
 <CAK8P3a1tiRew6uqegUXsKbNQG7=sPVFMY3yXf0M7OjJdkxM=_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1tiRew6uqegUXsKbNQG7=sPVFMY3yXf0M7OjJdkxM=_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:03:07AM +0200, Arnd Bergmann wrote:
> On Wed, Apr 17, 2019 at 11:13 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Apr 16, 2019 at 10:19:40PM +0200, Arnd Bergmann wrote:
> > > diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> > > index c708400fff4a..04252c3492ee 100644
> > > --- a/drivers/net/ppp/ppp_generic.c
> > > +++ b/drivers/net/ppp/ppp_generic.c
> > > @@ -899,6 +899,7 @@ static const struct file_operations ppp_device_fops = {
> > >       .write          = ppp_write,
> > >       .poll           = ppp_poll,
> > >       .unlocked_ioctl = ppp_ioctl,
> > > +     .compat_ioctl   = ppp_ioctl,
> >
> > Oh?  What happens on e.g. s390 with something like PPPIOCNEWUNIT?
> > Current kernel:
> >         * no ->compat_ioctl()
> >         * ->unlock_ioctl() is present
> >         * found by compat_ioctl_check_table()
> >         * pass (unsigned long)compat_ptr(arg) to do_vfs_ioctl()
> >         * pass that to ppp_ioctl()
> >         * pass that to ppp_unattached_ioctl()
> >         * fetch int from (int __user *)compat_ptr(arg)
> >
> > With your patch:
> >         * call ppp_ioctl()
> >         * pass arg to ppp_unattached_ioctl()
> >         * fetch int from (int __user *)arg
> >
> > AFAICS, that's broken...
> 
> Correct. I had added this patch to the series from an older set of
> patches (predating
> the compat_ptr_ioctl() series) , and did not check for this issue again. When
> I originally created the patch, I assumed that even on s390 it would be no
> problem.
> 
> > Looking at that ppp_ioctl(),
> > pointer to arch-independent type or ignored:
> >         PPPIOCNEWUNIT PPPIOCATTACH PPPIOCATTCHAN PPPIOCSMRU PPPIOCSFLAGS
> >         PPPIOCGFLAGS PPPIOCGUNIT PPPIOCSDEBUG PPPIOCSMAXCID PPPIOCCONNECT
> >         PPPIOCGDEBUG PPPIOCSMAXCID PPPIOCSMRRU
> >         PPPIOCDETACH PPPIOCDISCONN
> >         PPPIOCGASYNCMAP PPPIOCSASYNCMAP PPPIOCGRASYNCMAP PPPIOCSRASYNCMAP
> >         PPPIOCGXASYNCMAP PPPIOCSXASYNCMAP
> >         PPPIOCGNPMODE PPPIOCSNPMODE
> > pointer to struct ppp_option_data (with further pointer-chasing in it):
> >         PPPIOCSCOMPRESS
> > pointer to struct ppp_idle:
> >         PPPIOCGIDLE
> > pointer to struct sock_filter (with hidden pointer-chasing, AFAICS):
> >         PPPIOCSPASS PPPIOCSACTIVE
> >
> > Pretty much all of them take pointers.  What's more, reaction to
> > unknown is -ENOTTY, not -ENOIOCTLCM, so that patch will have
> > prevent the translated ones from reaching do_ioctl_trans()
> 
> Good point, this patch sequence does break bisection.
> 
> > What am I missing here?  Why not simply do
> >
> > compat_ppp_ioctl()
> > {
> >         PPPIOCSCOMPRESS32 => deal with it
> >         PPPIOCGIDLE32 => deal with it
> >         PPPIOCSPASS32 / PPPIOCSACTIVE32 => deal with it
> >         default: pass compat_ptr(arg) to ppp_ioctl() and be done with that
> > }
> >
> > with BPF-related bits (both compat and native) taken to e.g. net/core/bpf-ppp.c,
> > picked by both generic and isdn?  IDGI...
> 
> I was trying to unify the native and compat code paths as much
> as possible here. Handling the four PPPIO*32 commands in
> compat_ppp_ioctl would either require duplicating large chunks
> of ppp_ioctl, or keeping the extra compat_alloc_user_space()
> copy from the existing implementation.
> 
> I'll try to come up with a different way to structure the patches.

Huh?  Instead of
        case PPPIOCSCOMPRESS:
                err = ppp_set_compress(ppp, arg);
                break;
in native, have
	struct ppp_option_data data;
...
        case PPPIOCSCOMPRESS:
		if (copy_from_user(&data, argp, sizeof(data)))
			err = -EFAULT;
		else
			err = ppp_set_compress(ppp, &data);
                break;

while in compat do
	struct ppp_option_data32 data32;

        case PPPIOCSCOMPRESS32:
		if (copy_from_user(&data32, argp, sizeof(data32)))
			err = -EFAULT;
		else
			err = ppp_set_compress(ppp, &(struct ppp_option_data){
							.ptr = compat_ptr(data32.ptr),
							.length = data32.length,
							.transmit = data32.transmit
						});
		break;

PPPIOCGIDLE is small to start with - not a lot to copy there.
And as for the filters...  What you need is something like

struct bpf_prog *get_ppp_bpf(struct sock_fprog __user *p)
{
        struct sock_fprog uprog;
	struct sock_fprog_kern fprog;
	struct sock_filter *code = NULL;
	struct bpf_prog *res;
        int err;

        if (copy_from_user(&uprog, p, sizeof(uprog)))
                return ERR_PTR(-EFAULT);

        if (!uprog.len)
                return NULL;

        fprog.len = uprog.len * sizeof(struct sock_filter);
        code = fprog.filter = memdup_user(uprog.filter, fprog.len);
        if (IS_ERR(code))
                return ERR_CAST(code);

	err = bpf_prog_create(&res, &fprog);
	kfree(code);

	if (err)
		return ERR_PTR(err);
	return res;
}
in net/core/ppp-filter.c (or in net/core/filter.c, for that matter, under
appropriate ifdef)) with obvious compat counterpart next to it.  Hell,
turn the above into

static struct bpf_prog *__get_ppp_bpf(struct sock_fprog *kp)
{
	struct sock_fprog_kern fprog;
	struct sock_filter *code = NULL;
	struct bpf_prog *res;
        int err;

        if (!kp->len)
                return NULL;

        fprog.len = kp->len * sizeof(struct sock_filter);
        code = fprog.filter = memdup_user(kp->filter, fprog.len);
        if (IS_ERR(code))
                return ERR_CAST(code);

	err = bpf_prog_create(&res, &fprog);
	kfree(code);

	if (err)
		return ERR_PTR(err);
	return res;
}

struct bpf_prog *get_ppp_bpf(struct sock_fprog __user *p)
{
        struct sock_fprog uprog;

        if (copy_from_user(&uprog, p, sizeof(uprog)))
                return ERR_PTR(-EFAULT);
	return __get_ppp_bpf(&uprog);
}

struct bpf_prog *compat_get_ppp_bpf(struct sock_fprog32 __user *p)
{
        struct sock_fprog uprog32;

        if (copy_from_user(&uprog32, p, sizeof(uprog32)))
                return ERR_PTR(-EFAULT);
	return __get_ppp_bpf(&(struct sock_fprog){
			.len = uprog32.len,
			.filter = compat_ptr(uprog32.filter)});
}

Then in native ioctl do
        case PPPIOCSPASS:
        case PPPIOCSACTIVE:
        {
                struct bpf_prog *filter = get_bpf_ppp(argp);

		if (IS_ERR(filter)) {
			err = PTR_ERR(filter);
		} else {
			struct bpf_prog **which;
			if (cmd == PPPIOCSPASS)
				which = &ppp->pass_filter;
			else
				which = &ppp->active_filter;
			ppp_lock(ppp);
			if (*which)
				bpf_prog_destroy(*which);
			*which = filter;
			ppp_unlock(ppp);
			err = 0;
		}
                break;
	}
in native and similar in compat, with get_bpf_ppp() replaced
with call of compat_get_bpf_ppp() and ioctl numbers obviously
adjusted.  All there is to it...  Helpers obviously shared
with isdn and yes, all crap gone from fs/compat_ioctl.c...

Why would you want to duplicate large chunks of anything?
The above is not even compile-tested, but...  I can put
together a patch if you wish.  Or am I missing something
here?
