Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9271AC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594A121835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfLFHXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:23:36 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:42532 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfLFHXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:23:36 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1id7xZ-0007E5-Jn; Fri, 06 Dec 2019 07:23:30 +0000
Received: from sleer.kot-begemot.co.uk ([192.168.3.72])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1id7xX-0005Wb-0l; Fri, 06 Dec 2019 07:23:29 +0000
Subject: Re: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
To:     Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com,
        richard@nod.at
Cc:     johannes.berg@intel.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, davidgow@google.com
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-2-brendanhiggins@google.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
Date:   Fri, 6 Dec 2019 07:23:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206020153.228283-2-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2019 02:01, Brendan Higgins wrote:
> Remove support for UML_NET_PCAP. It is broken. When building with
> libpcap installed, the build fails:
> 
> arch/um/drivers/pcap_user.c:35:12: error: conflicting types for ‘pcap_open’
>   static int pcap_open(void *data)
>              ^~~~~~~~~
> In file included from /usr/include/pcap.h:43,
>                   from arch/um/drivers/pcap_user.c:7:
> /usr/include/pcap/pcap.h:859:18: note: previous declaration of ‘pcap_open’ was here
>   PCAP_API pcap_t *pcap_open(const char *source, int snaplen, int flags,
>                    ^~~~~~~~~
> 
> So it looks like this has probably been broken for some time.
> 
> In interest of trying to make allyesconfig work with UML, it is best
> just to drop this.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   arch/um/drivers/Kconfig     |  16 -----
>   arch/um/drivers/Makefile    |  17 +----
>   arch/um/drivers/pcap_kern.c | 113 -----------------------------
>   arch/um/drivers/pcap_user.c | 137 ------------------------------------
>   arch/um/drivers/pcap_user.h |  21 ------
>   5 files changed, 2 insertions(+), 302 deletions(-)
>   delete mode 100644 arch/um/drivers/pcap_kern.c
>   delete mode 100644 arch/um/drivers/pcap_user.c
>   delete mode 100644 arch/um/drivers/pcap_user.h
> 
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 388096fb45a25..98fead07c33de 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -291,22 +291,6 @@ config UML_NET_MCAST
>   	  exclusive).  If you don't need to network UMLs say N to each of
>   	  the transports.
>   
> -config UML_NET_PCAP
> -	bool "pcap transport"
> -	depends on UML_NET
> -	help
> -	The pcap transport makes a pcap packet stream on the host look
> -	like an ethernet device inside UML.  This is useful for making
> -	UML act as a network monitor for the host.  You must have libcap
> -	installed in order to build the pcap transport into UML.
> -
> -	  For more information, see
> -	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
> -	  has examples of the UML command line to use to enable this option.
> -
> -	If you intend to use UML as a network monitor for the host, say
> -	Y here.  Otherwise, say N.
> -
>   config UML_NET_SLIRP
>   	bool "SLiRP transport"
>   	depends on UML_NET
> diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
> index a290821e355c2..7548b18e77a27 100644
> --- a/arch/um/drivers/Makefile
> +++ b/arch/um/drivers/Makefile
> @@ -3,9 +3,6 @@
>   # Copyright (C) 2000, 2002, 2003 Jeff Dike (jdike@karaya.com)
>   #
>   
> -# pcap is broken in 2.5 because kbuild doesn't allow pcap.a to be linked
> -# in to pcap.o
> -
>   slip-objs := slip_kern.o slip_user.o
>   slirp-objs := slirp_kern.o slirp_user.o
>   daemon-objs := daemon_kern.o daemon_user.o
> @@ -18,14 +15,9 @@ ubd-objs := ubd_kern.o ubd_user.o
>   port-objs := port_kern.o port_user.o
>   harddog-objs := harddog_kern.o harddog_user.o
>   
> -LDFLAGS_pcap.o := -r $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
> -
>   LDFLAGS_vde.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
>   
> -targets := pcap_kern.o pcap_user.o vde_kern.o vde_user.o
> -
> -$(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
> -	$(LD) -r -dp -o $@ $^ $(ld_flags)
> +targets := vde_kern.o vde_user.o
>   
>   $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
>   	$(LD) -r -dp -o $@ $^ $(ld_flags)
> @@ -34,9 +26,6 @@ $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
>   # object name, so nothing from the library gets linked.
>   #$(call if_changed,ld)
>   
> -# When the above is fixed, don't forget to add this too!
> -#targets += $(obj)/pcap.o
> -
>   obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
>   obj-$(CONFIG_SSL) += ssl.o
>   obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
> @@ -47,7 +36,6 @@ obj-$(CONFIG_UML_NET_DAEMON) += daemon.o
>   obj-$(CONFIG_UML_NET_VECTOR) += vector.o
>   obj-$(CONFIG_UML_NET_VDE) += vde.o
>   obj-$(CONFIG_UML_NET_MCAST) += umcast.o
> -obj-$(CONFIG_UML_NET_PCAP) += pcap.o
>   obj-$(CONFIG_UML_NET) += net.o
>   obj-$(CONFIG_MCONSOLE) += mconsole.o
>   obj-$(CONFIG_MMAPPER) += mmapper_kern.o
> @@ -63,8 +51,7 @@ obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
>   obj-$(CONFIG_UML_RANDOM) += random.o
>   obj-$(CONFIG_VIRTIO_UML) += virtio_uml.o
>   
> -# pcap_user.o must be added explicitly.
> -USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o vde_user.o vector_user.o
> +USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o vde_user.o vector_user.o
>   CFLAGS_null.o = -DDEV_NULL=$(DEV_NULL_PATH)
>   
>   include arch/um/scripts/Makefile.rules
> diff --git a/arch/um/drivers/pcap_kern.c b/arch/um/drivers/pcap_kern.c
> deleted file mode 100644
> index cfe4cb17694cc..0000000000000
> --- a/arch/um/drivers/pcap_kern.c
> +++ /dev/null
> @@ -1,113 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#include <linux/init.h>
> -#include <linux/netdevice.h>
> -#include <net_kern.h>
> -#include "pcap_user.h"
> -
> -struct pcap_init {
> -	char *host_if;
> -	int promisc;
> -	int optimize;
> -	char *filter;
> -};
> -
> -void pcap_init(struct net_device *dev, void *data)
> -{
> -	struct uml_net_private *pri;
> -	struct pcap_data *ppri;
> -	struct pcap_init *init = data;
> -
> -	pri = netdev_priv(dev);
> -	ppri = (struct pcap_data *) pri->user;
> -	ppri->host_if = init->host_if;
> -	ppri->promisc = init->promisc;
> -	ppri->optimize = init->optimize;
> -	ppri->filter = init->filter;
> -
> -	printk("pcap backend, host interface %s\n", ppri->host_if);
> -}
> -
> -static int pcap_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return pcap_user_read(fd, skb_mac_header(skb),
> -			      skb->dev->mtu + ETH_HEADER_OTHER,
> -			      (struct pcap_data *) &lp->user);
> -}
> -
> -static int pcap_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
> -{
> -	return -EPERM;
> -}
> -
> -static const struct net_kern_info pcap_kern_info = {
> -	.init			= pcap_init,
> -	.protocol		= eth_protocol,
> -	.read			= pcap_read,
> -	.write			= pcap_write,
> -};
> -
> -int pcap_setup(char *str, char **mac_out, void *data)
> -{
> -	struct pcap_init *init = data;
> -	char *remain, *host_if = NULL, *options[2] = { NULL, NULL };
> -	int i;
> -
> -	*init = ((struct pcap_init)
> -		{ .host_if 	= "eth0",
> -		  .promisc 	= 1,
> -		  .optimize 	= 0,
> -		  .filter 	= NULL });
> -
> -	remain = split_if_spec(str, &host_if, &init->filter,
> -			       &options[0], &options[1], mac_out, NULL);
> -	if (remain != NULL) {
> -		printk(KERN_ERR "pcap_setup - Extra garbage on "
> -		       "specification : '%s'\n", remain);
> -		return 0;
> -	}
> -
> -	if (host_if != NULL)
> -		init->host_if = host_if;
> -
> -	for (i = 0; i < ARRAY_SIZE(options); i++) {
> -		if (options[i] == NULL)
> -			continue;
> -		if (!strcmp(options[i], "promisc"))
> -			init->promisc = 1;
> -		else if (!strcmp(options[i], "nopromisc"))
> -			init->promisc = 0;
> -		else if (!strcmp(options[i], "optimize"))
> -			init->optimize = 1;
> -		else if (!strcmp(options[i], "nooptimize"))
> -			init->optimize = 0;
> -		else {
> -			printk(KERN_ERR "pcap_setup : bad option - '%s'\n",
> -			       options[i]);
> -			return 0;
> -		}
> -	}
> -
> -	return 1;
> -}
> -
> -static struct transport pcap_transport = {
> -	.list 		= LIST_HEAD_INIT(pcap_transport.list),
> -	.name 		= "pcap",
> -	.setup  	= pcap_setup,
> -	.user 		= &pcap_user_info,
> -	.kern 		= &pcap_kern_info,
> -	.private_size 	= sizeof(struct pcap_data),
> -	.setup_size 	= sizeof(struct pcap_init),
> -};
> -
> -static int register_pcap(void)
> -{
> -	register_transport(&pcap_transport);
> -	return 0;
> -}
> -
> -late_initcall(register_pcap);
> diff --git a/arch/um/drivers/pcap_user.c b/arch/um/drivers/pcap_user.c
> deleted file mode 100644
> index bbd20638788af..0000000000000
> --- a/arch/um/drivers/pcap_user.c
> +++ /dev/null
> @@ -1,137 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#include <errno.h>
> -#include <pcap.h>
> -#include <string.h>
> -#include <asm/types.h>
> -#include <net_user.h>
> -#include "pcap_user.h"
> -#include <um_malloc.h>
> -
> -#define PCAP_FD(p) (*(int *)(p))
> -
> -static int pcap_user_init(void *data, void *dev)
> -{
> -	struct pcap_data *pri = data;
> -	pcap_t *p;
> -	char errors[PCAP_ERRBUF_SIZE];
> -
> -	p = pcap_open_live(pri->host_if, ETH_MAX_PACKET + ETH_HEADER_OTHER,
> -			   pri->promisc, 0, errors);
> -	if (p == NULL) {
> -		printk(UM_KERN_ERR "pcap_user_init : pcap_open_live failed - "
> -		       "'%s'\n", errors);
> -		return -EINVAL;
> -	}
> -
> -	pri->dev = dev;
> -	pri->pcap = p;
> -	return 0;
> -}
> -
> -static int pcap_open(void *data)
> -{
> -	struct pcap_data *pri = data;
> -	__u32 netmask;
> -	int err;
> -
> -	if (pri->pcap == NULL)
> -		return -ENODEV;
> -
> -	if (pri->filter != NULL) {
> -		err = dev_netmask(pri->dev, &netmask);
> -		if (err < 0) {
> -			printk(UM_KERN_ERR "pcap_open : dev_netmask failed\n");
> -			return -EIO;
> -		}
> -
> -		pri->compiled = uml_kmalloc(sizeof(struct bpf_program),
> -					UM_GFP_KERNEL);
> -		if (pri->compiled == NULL) {
> -			printk(UM_KERN_ERR "pcap_open : kmalloc failed\n");
> -			return -ENOMEM;
> -		}
> -
> -		err = pcap_compile(pri->pcap,
> -				   (struct bpf_program *) pri->compiled,
> -				   pri->filter, pri->optimize, netmask);
> -		if (err < 0) {
> -			printk(UM_KERN_ERR "pcap_open : pcap_compile failed - "
> -			       "'%s'\n", pcap_geterr(pri->pcap));
> -			goto out;
> -		}
> -
> -		err = pcap_setfilter(pri->pcap, pri->compiled);
> -		if (err < 0) {
> -			printk(UM_KERN_ERR "pcap_open : pcap_setfilter "
> -			       "failed - '%s'\n", pcap_geterr(pri->pcap));
> -			goto out;
> -		}
> -	}
> -
> -	return PCAP_FD(pri->pcap);
> -
> - out:
> -	kfree(pri->compiled);
> -	return -EIO;
> -}
> -
> -static void pcap_remove(void *data)
> -{
> -	struct pcap_data *pri = data;
> -
> -	if (pri->compiled != NULL)
> -		pcap_freecode(pri->compiled);
> -
> -	if (pri->pcap != NULL)
> -		pcap_close(pri->pcap);
> -}
> -
> -struct pcap_handler_data {
> -	char *buffer;
> -	int len;
> -};
> -
> -static void handler(u_char *data, const struct pcap_pkthdr *header,
> -		    const u_char *packet)
> -{
> -	int len;
> -
> -	struct pcap_handler_data *hdata = (struct pcap_handler_data *) data;
> -
> -	len = hdata->len < header->caplen ? hdata->len : header->caplen;
> -	memcpy(hdata->buffer, packet, len);
> -	hdata->len = len;
> -}
> -
> -int pcap_user_read(int fd, void *buffer, int len, struct pcap_data *pri)
> -{
> -	struct pcap_handler_data hdata = ((struct pcap_handler_data)
> -		                          { .buffer  	= buffer,
> -					    .len 	= len });
> -	int n;
> -
> -	n = pcap_dispatch(pri->pcap, 1, handler, (u_char *) &hdata);
> -	if (n < 0) {
> -		printk(UM_KERN_ERR "pcap_dispatch failed - %s\n",
> -		       pcap_geterr(pri->pcap));
> -		return -EIO;
> -	}
> -	else if (n == 0)
> -		return 0;
> -	return hdata.len;
> -}
> -
> -const struct net_user_info pcap_user_info = {
> -	.init		= pcap_user_init,
> -	.open		= pcap_open,
> -	.close	 	= NULL,
> -	.remove	 	= pcap_remove,
> -	.add_address	= NULL,
> -	.delete_address = NULL,
> -	.mtu		= ETH_MAX_PACKET,
> -	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_OTHER,
> -};
> diff --git a/arch/um/drivers/pcap_user.h b/arch/um/drivers/pcap_user.h
> deleted file mode 100644
> index 216246f5f09bd..0000000000000
> --- a/arch/um/drivers/pcap_user.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
> - */
> -
> -#include <net_user.h>
> -
> -struct pcap_data {
> -	char *host_if;
> -	int promisc;
> -	int optimize;
> -	char *filter;
> -	void *compiled;
> -	void *pcap;
> -	void *dev;
> -};
> -
> -extern const struct net_user_info pcap_user_info;
> -
> -extern int pcap_user_read(int fd, void *buf, int len, struct pcap_data *pri);
> -
> 

1. There is a proposed patch for the build system to fix it.

2. We should be removing all old drivers and replacing them with the 
vector ones.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
