Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359D4C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED3D20880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="RtUf/zNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfGQJkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:40:25 -0400
Received: from first.geanix.com ([116.203.34.67]:36452 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfGQJkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:40:25 -0400
Received: from [192.168.8.20] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id C917C4421F;
        Wed, 17 Jul 2019 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1563356388; bh=W6wvd7gLObIcP74LGGkuvXYl3r/mNB18UfupZO1FpvA=;
        h=To:Cc:From:Subject:Date;
        b=RtUf/zNEU0Snubdfk4pv8TQciGFosmKUJ5cbmuaXULm3reURA3iC0xPcDuM0Pi6Q/
         ASXZ6NZWujvuXkaa5cOD9AY43JCgGafTZJ+XVBMJNmFPdo8zvhPQB5aFpYtmqJpIyX
         zY8zGUSLZ+7TKxUTD+DGlh+CuDfdcAtMhPnAxmeEQYnfl2NaO0M0MF4jHvVVf3u5ML
         zAaCscv2z4HKdxTMxP2j7bbOzaevCS+UQqVSRsjttY0AORgsYJq5CfNBVxYEFCzK8t
         KaZEXWdYGxdF2IgMpzsq+66LdkHaO8gRoLCBzwqpruVK0MzvRVV5K0bVap/wd7tJny
         oogzq4yoelgzA==
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dirkjan Bussink <dirkjan.bussink@nedap.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Subject: [BUG] n_gsm: possible recursive locking detected
Message-ID: <e2e9cc8f-6bb4-f66f-2d2b-3875c2e66cd3@geanix.com>
Date:   Wed, 17 Jul 2019 11:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7FC9DFE90750F6147532B214"
Content-Language: en-US-large
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7FC9DFE90750F6147532B214
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

The GSM0710 line discipline driver triggers a lockdep warning when 
disabling the ldisc while holding a multiplexed virtual tty open:

============================================
WARNING: possible recursive locking detected
5.2.0-00114-gdab52e30156b #6 Not tainted
--------------------------------------------
cmux/263 is trying to acquire lock:
e1e23b18 (&tty->legacy_mutex){+.+.}, at: __tty_hangup.part.0+0x58/0x27c

but task is already holding lock:
d6eddf48 (&tty->legacy_mutex){+.+.}, at: tty_set_ldisc+0x3c/0x1bc

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&tty->legacy_mutex);
   lock(&tty->legacy_mutex);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

3 locks held by cmux/263:
  #0: d6eddf48 (&tty->legacy_mutex){+.+.}, at: tty_set_ldisc+0x3c/0x1bc
  #1: f28bead9 (&tty->ldisc_sem){++++}, at: tty_ldisc_lock+0x50/0x74
  #2: e5d20e4f (&gsm->mutex){+.+.}, at: gsm_cleanup_mux+0x9c/0x15c

stack backtrace:
CPU: 0 PID: 263 Comm: cmux Not tainted 5.2.0-00114-gdab52e30156b #6
Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[<c011184c>] (unwind_backtrace) from [<c010cc74>] (show_stack+0x10/0x14)
[<c010cc74>] (show_stack) from [<c0852488>] (dump_stack+0xd4/0x108)
[<c0852488>] (dump_stack) from [<c017be90>] (__lock_acquire+0x6ec/0x1e84)
[<c017be90>] (__lock_acquire) from [<c017ddc4>] (lock_acquire+0xcc/0x204)
[<c017ddc4>] (lock_acquire) from [<c086e9d0>] (__mutex_lock+0x64/0x90c)
[<c086e9d0>] (__mutex_lock) from [<c086f294>] (mutex_lock_nested+0x1c/0x24)
[<c086f294>] (mutex_lock_nested) from [<c04c02fc>] 
(__tty_hangup.part.0+0x58/0x27c)
[<c04c02fc>] (__tty_hangup.part.0) from [<c04ce718>] 
(gsm_cleanup_mux+0xe8/0x15c)
[<c04ce718>] (gsm_cleanup_mux) from [<c04ce7d4>] (gsmld_close+0x48/0x90)
[<c04ce7d4>] (gsmld_close) from [<c04c7e24>] (tty_set_ldisc+0xb8/0x1bc)
[<c04c7e24>] (tty_set_ldisc) from [<c04c0b70>] (tty_ioctl+0x640/0xcb0)
[<c04c0b70>] (tty_ioctl) from [<c0297e68>] (do_vfs_ioctl+0x41c/0xa5c)
[<c0297e68>] (do_vfs_ioctl) from [<c02984dc>] (ksys_ioctl+0x34/0x60)
[<c02984dc>] (ksys_ioctl) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xc8ce1fa8 to 0xc8ce1ff0)
1fa0:                   00438000 00000000 00000003 00005423 beb6cc04 
beb6cc04
1fc0: 00438000 00000000 00000000 00000036 00000000 00000000 00438000 
beb6ccd4
1fe0: 00438048 beb6cbfc 00427684 b6f58b88


Steps to reproduce using the attached cmux util:

root@iwg26:~# ./cmux &
[1] 254
SERIAL_PORT = /dev/ttymxc0
AT+IFC=2: Ie5   +CFUN: 1    +CPIN: READY    Call Ready  AT+IFC=2,2   OK
AT+GMM  : AT+GMM   Quectel_M95    OK
AT      : AT   OK
AT+IPR=1: AT+IPR=115200&w   OK
AT+CMUX=: AT+CMUX=0,0,5,512,10,3,30,10,2   OK
Line dicipline set

root@iwg26:~# cat /dev/gsmtty1 &
[2] 262
root@iwg26:~# kill %1
[   74.517449] ============================================
[   74.522769] WARNING: possible recursive locking detected
[   74.528094] 5.2.0-00114-gdab52e30156b #6 Not tainted
[   74.533065] --------------------------------------------
<...>


This has supposedly been fixed before in 4d9b109060f6 ("tty: Prevent 
deadlock in n_gsm driver"), but the fix was undone in be7065725590 
("TTY/n_gsm: Removing the wrong tty_unlock/lock() in gsm_dlci_release()")

-- 
Kind regards,
Martin Hundebøll
Embedded Linux Consultant

+45 61 65 54 61
martin@geanix.com

Geanix ApS
https://geanix.com
DK39600706

--------------7FC9DFE90750F6147532B214
Content-Type: text/x-csrc;
 name="cmux.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cmux.c"

/**
*	Cmux
*	Enables GSM 0710 multiplex using n_gsm
*
*	Copyright (C) 2013 - Rtone - Nicolas Le Manchet <nicolaslm@rtone.fr>
*
*	This program is free software: you can redistribute it and/or modify
*	it under the terms of the GNU General Public License as published by
*	the Free Software Foundation, either version 3 of the License, or
*	(at your option) any later version.
*
*	This program is distributed in the hope that it will be useful,
*	but WITHOUT ANY WARRANTY; without even the implied warranty of
*	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*	GNU General Public License for more details.
*
*	You should have received a copy of the GNU General Public License
*	along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*/
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>
#include <termios.h>
#include <net/if.h>
#include <linux/types.h>
#include <linux/gsmmux.h>
#include <sys/sysmacros.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <err.h>
#include <signal.h>

/* n_gsm ioctl */
#ifndef N_GSM0710
# define N_GSM0710	21
#endif

/* attach a line discipline ioctl */
#ifndef TIOCSETD
# define TIOCSETD	0x5423
#endif

/* serial port of the modem */
#define SERIAL_PORT	"/dev/ttymxc0"

/* line speed */
#define LINE_SPEED	B115200

/* maximum transfert unit (MTU), value in bytes */
#define MTU	512

/**
* whether or not to create virtual TTYs for the multiplex
*	0 : do not create
*	1 : create
*/
#define CREATE_NODES	0

/* number of virtual TTYs to create (most modems can handle up to 4) */
#define NUM_NODES	4

/* name of the virtual TTYs to create */
#define BASENAME_NODES	"/dev/ttyGSM"

/* name of the driver, used to get the major number */
#define DRIVER_NAME	"gsmtty"

/**
* whether or not to print debug messages to stderr
*	0 : debug off
*	1 : debug on
*/
#define DEBUG	1

/**
* whether or not to detach the program from the terminal
*	0 : do not daemonize
*	1 : daemonize
*/
#define DAEMONIZE	0

 /* size of the reception buffer which gets data from the serial line */
#define SIZE_BUF	256


/**
*	Prints debug messages to stderr if debug is wanted
*/
static void dbg(char *fmt, ...) {
	
	va_list args;

	if (DEBUG) {
		fflush(NULL);
		va_start(args, fmt);
		vfprintf(stderr, fmt, args);
		va_end(args);
		fprintf(stderr, "\n");
		fflush(NULL);
	}
	return;
}

/**
*	Sends an AT command to the specified line and gets its result
*	Returns  0 on success
*			-1 on failure
*/
int send_at_command(int serial_fd, char *command) {
	
	char buf[SIZE_BUF];
	int r;

	/* write the AT command to the serial line */
	if (write(serial_fd, command, strlen(command)) <= 0)
		err(EXIT_FAILURE, "Cannot write to %s", SERIAL_PORT);
	
	/* wait a bit to allow the modem to rest */
	sleep(1);

	/* read the result of the command from the modem */
	memset(buf, 0, sizeof(buf));
	r = read(serial_fd, buf, sizeof(buf));
	if (r == -1)
		err(EXIT_FAILURE, "Cannot read %s", SERIAL_PORT);
	
	/* if there is no result from the modem, return failure */
	if (r == 0) {
		dbg("%s\t: No response", command);
		return -1;
	}

	/* if we have a result and want debug info, strip CR & LF out from the output */
	if (DEBUG) {
		int i;
		char bufp[SIZE_BUF];
		memcpy(bufp, buf, sizeof(buf));
		for(i=0; i<strlen(bufp); i++) {
			if (bufp[i] == '\r' || bufp[i] == '\n')
				bufp[i] = ' ';
		}
		dbg("%s\t: %s", command, bufp);
	}

	/* if the output shows "OK" return success */
	if (strstr(buf, "OK\r") != NULL) {
		return 0;
	}
	
	return -1;		

}

/**
*	Function raised by signal catching
*/
void signal_callback_handler(int signum) {
	return;
}

/**
*	Gets the major number of the driver device
*	Returns  the major number on success
*			-1 on failure
*/
int get_major(char *driver) {

	FILE *fp;
	char *line = NULL;
	size_t len = 0;
	ssize_t read;
	char device[20];
	int major = -1;
	
	/* open /proc/devices file */
	if ((fp = fopen("/proc/devices", "r")) == NULL)
		err(EXIT_FAILURE, "Cannot open /proc/devices");

	/* read the file line by line */
	while ((major == -1) && (read = getline(&line, &len, fp)) != -1) {
		
		/* if the driver name string is found in the line, try to get the major */
		if (strstr(line, driver) != NULL) {
			if (sscanf(line,"%d %s\n", &major, device) != 2)
				major = -1;
		}
		
		/* free the line before getting a new one */
		if (line) {
			free(line);
			line = NULL;
		}

	}

	/* close /proc/devices file */
	fclose(fp);

	return major;
}

/**
*	Creates nodes for the virtual TTYs
*	Returns the number of nodes created
*/
int make_nodes(int major, char *basename, int number_nodes) {

	int minor, created = 0;
	dev_t device;
	char node_name[15];
	mode_t oldmask;

	/* set a new mask to get 666 mode and stores the old one */
	oldmask = umask(0);

	for (minor=1; minor<number_nodes+1; minor++) {

		/* append the minor number to the base name */
		sprintf(node_name, "%s%d", basename, minor);
		
		/* store a device info with major and minor */
		device = makedev(major, minor);
		
		/* create the actual character node */
		if (mknod(node_name, S_IFCHR | 0666, device) != 0) {
			warn("Cannot create %s", node_name);
		} else {
			created++;
			dbg("Created %s", node_name);
		}

	}

	/* revert the mask to the old one */
	umask(oldmask);

	return created;
}

/**
*	Removes previously created TTY nodes
*	Returns nothing, it doesn't really matter if it fails
*/
void remove_nodes(char *basename, int number_nodes) {

	int node;
	char node_name[15];

	for (node=1; node<number_nodes+1; node++) {

		/* append the minor number to the base name */
		sprintf(node_name, "%s%d", basename, node);
			
		/* unlink the actual character node */
		dbg("Removing %s", node_name);
		if (unlink(node_name) == -1)
			warn("Cannot remove %s", node_name);

	}

	return;
}

int main(void) {

	int serial_fd, major;
	struct termios tio;
	int ldisc = N_GSM0710;
	int ldisc_save;
	struct gsm_config gsm;
	char atcommand[40];
	//char disconnect[] = {0xf9, 0x03, 0xef, 0x03, 0xc3, 0x16, 0xf9};
	char disconnect[] = {0xf9, 0x03, 0xef, 0x05, 0xc3, 0x01, 0xf2, 0xf9};

	/* print global parameters */
	dbg("SERIAL_PORT = %s", SERIAL_PORT);

	/* open the serial port */
	serial_fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);
	if (serial_fd == -1)
		err(EXIT_FAILURE, "Cannot open %s", SERIAL_PORT);
	
	/* get the current attributes of the serial port */
	if (tcgetattr(serial_fd, &tio) == -1)
		err(EXIT_FAILURE, "Cannot get line attributes");
	
	/* set the new attrbiutes */
	tio.c_iflag = 0;
	tio.c_oflag = 0;
	tio.c_cflag = CS8 | CREAD | CLOCAL;
	tio.c_cflag |= CRTSCTS;
	tio.c_lflag = 0;
	tio.c_cc[VMIN] = 1;
	tio.c_cc[VTIME] = 0;
	
	/* write the speed of the serial line */
	if (cfsetospeed(&tio, LINE_SPEED) < 0 || cfsetispeed(&tio, LINE_SPEED) < 0)
		err(EXIT_FAILURE, "Cannot set line speed");
	
	/* write the attributes */
	if (tcsetattr(serial_fd, TCSANOW, &tio) == -1)
		err(EXIT_FAILURE, "Cannot set line attributes");

	/**
	*	Send AT commands to put the modem in CMUX mode.
	*	This is vendor specific and should be changed 
	*	to fit your modem needs.
	*	The following matches Quectel M95.
	*/
	if (send_at_command(serial_fd, "AT+IFC=2,2\r") == -1)
		errx(EXIT_FAILURE, "AT+IFC=2,2: bad response");	
	if (send_at_command(serial_fd, "AT+GMM\r") == -1)
		warnx("AT+GMM: bad response");
	if (send_at_command(serial_fd, "AT\r") == -1)
		warnx("AT: bad response");
	if (send_at_command(serial_fd, "AT+IPR=115200&w\r") == -1)
		errx(EXIT_FAILURE, "AT+IPR=115200&w: bad response");
	sprintf(atcommand, "AT+CMUX=0,0,5,%d,10,3,30,10,2\r", MTU);
	if (send_at_command(serial_fd, atcommand) == -1)
		errx(EXIT_FAILURE, "Cannot enable modem CMUX");

	if (ioctl(serial_fd, TIOCGETD, &ldisc_save) < 0)
		err(EXIT_FAILURE, "Cannot get current line discipline");

	/* use n_gsm line discipline */
	sleep(2);
	if (ioctl(serial_fd, TIOCSETD, &ldisc) < 0)
		err(EXIT_FAILURE, "Cannot set line dicipline. Is 'n_gsm' module registred?");

	/* get n_gsm configuration */
	if (ioctl(serial_fd, GSMIOC_GETCONF, &gsm) < 0)
		err(EXIT_FAILURE, "Cannot get GSM multiplex parameters");

	/* set and write new attributes */
	gsm.initiator = 1;
	gsm.encapsulation = 0;
	gsm.mru = MTU;
	gsm.mtu = MTU;
	gsm.t1 = 10;
	gsm.n2 = 3;
	gsm.t2 = 30;
	gsm.t3 = 10;

	if (ioctl(serial_fd, GSMIOC_SETCONF, &gsm) < 0)
		err(EXIT_FAILURE, "Cannot set GSM multiplex parameters");
	dbg("Line dicipline set");
	
	/* create the virtual TTYs */
	if (CREATE_NODES) {
		int created;
		if ((major = get_major(DRIVER_NAME)) < 0)
			errx(EXIT_FAILURE, "Cannot get major number");
		if ((created = make_nodes(major, BASENAME_NODES, NUM_NODES)) < NUM_NODES)
			warnx("Cannot create all nodes, only %d/%d have been created.", created, NUM_NODES);
	}

	/* detach from the terminal if needed */
	if (DAEMONIZE) {
		dbg("Going to background");
		if (daemon(0,0) != 0)
			err(EXIT_FAILURE, "Cannot daemonize");
	}

	/* wait to keep the line discipline enabled, wake it up with a signal */
	signal(SIGINT, signal_callback_handler);
	signal(SIGTERM, signal_callback_handler);
	pause();
	
	/* remove the created virtual TTYs */
	if (CREATE_NODES) {
		remove_nodes(BASENAME_NODES, NUM_NODES);
	}

	if (ioctl(serial_fd, TIOCSETD, &ldisc_save) < 0)
		err(EXIT_FAILURE, "Cannot set initial line dicipline");

	if (write(serial_fd, disconnect, sizeof(disconnect)) != sizeof(disconnect))
		err(EXIT_FAILURE, "Cannot disable modem CMUX");

	/* close the serial line */
	close(serial_fd);

	return EXIT_SUCCESS;
}

--------------7FC9DFE90750F6147532B214--
